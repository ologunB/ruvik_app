import 'package:flutter_google_maps_webservices/places.dart';
import 'package:lendo/core/apis/base_api.dart';
import 'package:lendo/core/models/restaurant_model.dart';
import 'package:lendo/views/home/search_address.dart';
import 'package:lendo/views/main_layout.dart';

import '../widgets/rev_text.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Categories> selectedTypes = [];
  double maxAmount = 200;
  late RangeValues minMax;

  MoneyMaskedTextController min = MoneyMaskedTextController();
  MoneyMaskedTextController max = MoneyMaskedTextController();
  TextEditingController location = TextEditingController();
  @override
  void initState() {
    dynamic data = {}..addAll(AppCache.getFilter());
    selectedTypes = data?['category']
            ?.map<Categories>((e) => Categories.fromJson(e))
            .toList() ??
        [];
    location = TextEditingController(text: data?['location']);
    max = MoneyMaskedTextController(
        initialValue: data?['price_max']?.toDouble() ?? maxAmount,
        leftSymbol: '\$ ');
    min = MoneyMaskedTextController(
        initialValue: data?['price_min']?.toDouble() ?? 0, leftSymbol: '\$ ');
    minMax = RangeValues(min.numberValue, max.numberValue);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width1 = (MediaQuery.of(context).size.width - 81.h) / 3;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 4.h,
        title: RevText(
          '${Navigator.canPop(context) ? 'Edit' : 'Prepare'} your Mystery Dinning',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.grey,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 1),
          child: Divider(height: 0, thickness: 1.h, color: Colors.black12),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 10.h),
        children: [
          RevField(
            key: const Key('location'),
            labelText: 'Location',
            hintText: 'Search for address',
            vertPadding: 13,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.search,
            suffix: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.h),
                  child: Image.asset('loc'.png, height: 24.h),
                ),
              ],
            ),
            controller: location,
            readOnly: true,
            onTap: () async {
              Prediction? a = await push(
                  context, SelectAddressScreen(pre: location.text), true);

              if (a == null) return;
              location.text = a.description!;
              setState(() {});
            },
          ),
          RevText(
            'Food Cuisines',
            fontSize: 14.sp,
            bottom: 8.h,
            top: 24.h,
            color: AppColors.black,
          ),
          Wrap(
            runSpacing: 16.h,
            spacing: 16.h,
            children: Utils.categories.map((value) {
              bool isPresent = selectedTypes.contains(value);
              return InkWell(
                key: Key(value.title!),
                onTap: () {
                  if (isPresent) {
                    selectedTypes.remove(value);
                  } else {
                    selectedTypes.add(value);
                  }
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(6.h),
                child: Container(
                  height: 40.h,
                  width: width1,
                  padding: EdgeInsets.symmetric(horizontal: 4.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isPresent ? AppColors.priBG : null,
                      borderRadius: BorderRadius.circular(6.h),
                      border: Border.all(
                          color: isPresent
                              ? AppColors.priBG
                              : const Color(0xffE0E0E0))),
                  child: RevText(
                    value.title!,
                    fontSize: 12.sp,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    color: isPresent ? AppColors.primary : AppColors.grey,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
          Divider(height: 0, thickness: 1.h, color: Colors.black12),
          RevText(
            'Price',
            fontSize: 14.sp,
            bottom: 8.h,
            top: 24.h,
            color: AppColors.black,
          ),
          Row(
            children: [
              Expanded(
                child: RevField(
                  labelText: 'Minimum Price',
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  vertPadding: 13,
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  controller: min,
                  color: AppColors.grey2,
                  textAlign: TextAlign.center,
                  onChanged: (_) {
                    if (max.numberValue > minMax.start &&
                        min.numberValue < maxAmount) {
                      minMax = RangeValues(min.numberValue, minMax.end);
                      setState(() {});
                    }
                  },
                ),
              ),
              SizedBox(width: 16.h),
              Expanded(
                child: RevField(
                  labelText: 'Maximum Price',
                  vertPadding: 13,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  color: AppColors.grey2,
                  controller: max,
                  textAlign: TextAlign.center,
                  onChanged: (_) {
                    if (max.numberValue > minMax.start &&
                        max.numberValue < maxAmount) {
                      minMax = RangeValues(minMax.start, max.numberValue);
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SliderTheme(
            data: SliderThemeData(
              overlayShape: SliderComponentShape.noOverlay,
              trackHeight: 2.h,
            ),
            child: RangeSlider(
              max: maxAmount,
              values: minMax,
              onChanged: (a) {
                minMax = a;
                min.updateValue(minMax.start);
                max.updateValue(minMax.end);
                setState(() {});
              },
              activeColor: AppColors.primary,
              inactiveColor: AppColors.grey2,
            ),
          ),
          SizedBox(height: 22.h),
          Divider(height: 0, thickness: 1.h, color: Colors.black12),
          SizedBox(height: 22.h),
          RevButton(
            'Confirm',
            buttonColor: AppColors.primary,
            height: 48,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            textColor: AppColors.white,
            borderColor: AppColors.white,
            onPressed: location.text.isEmpty
                ? null
                : () {
                    Map<String, dynamic> query = {};
                    query['price_min'] = min.numberValue.toInt();
                    query['price_max'] = max.numberValue.toInt();
                    query['category'] =
                        selectedTypes.map((e) => e.toJson()).toList();
                    query['location'] = location.text;
                    AppCache.setFilter(query);
                    !Navigator.canPop(context)
                        ? pushReplacement(context, const MainLayout())
                        : Navigator.pop(context, true);
                  },
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}
