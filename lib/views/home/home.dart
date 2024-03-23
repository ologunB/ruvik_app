import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lendo/core/models/restaurant_model.dart';
import 'package:lendo/views/home/details.dart';
import 'package:lendo/views/home/roulette.dart';
import 'package:lendo/views/widgets/rev_text.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/apis/local_storage.dart';
import '../../core/vms/restaurants_vm.dart';
import '../widgets/restaurant_item.dart';
import 'adventures.dart';
import 'filter.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 6.h),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.h),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 250.0,
          color: Colors.black12,
          child: Shimmer.fromColors(
            baseColor: AppColors.primaryLight.withOpacity(.2),
            highlightColor: Colors.white,
            child: Container(height: 100.0, color: Colors.black26),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Categories> selectedTypes = [];

  @override
  void initState() {
    dynamic data = {}..addAll(AppCache.getFilter());
    selectedTypes = data?['category']
            ?.map<Categories>((e) => Categories.fromJson(e))
            .toList() ??
        [];
    super.initState();
  }

  Timer? _debounce;

  void debounceFn(Function fn) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 400), () {
      fn();
      _debounce?.cancel();
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Categories> reorderList() {
      List<Categories> categories = Utils.categories;
      List<Categories> tempList = List.from(categories);

      tempList.sort((a, b) {
        int indexA = selectedTypes.indexOf(a);
        int indexB = selectedTypes.indexOf(b);

        if (indexA != -1 && indexB != -1) return indexA.compareTo(indexB);

        if (indexA != -1) return -1;

        if (indexB != -1) return 1;

        return categories.indexOf(a).compareTo(categories.indexOf(b));
      });

      return tempList;
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BaseView<RestaurantsViewModel>(
        onModelReady: (a) => a.getAll(first: true),
        builder: (_, model, __) => RefreshIndicator(
          onRefresh: () async {
            await model.getAll();
            return;
          },
          color: AppColors.primary,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            children: [
              SizedBox(height: 12.h),
              SafeArea(
                bottom: false,
                child: Row(
                  children: [
                    RevText(
                      model.res == null ? '' : 'What do you want to do?',
                      fontSize: 24.sp,
                      left: 24.h,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 24.h),
                    RevButton(
                      'Culinary Roulette',
                      buttonColor: AppColors.black,
                      height: 40,
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 12.h),
                            child: Image.asset(
                              'roulette'.png,
                              height: 24.h,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      onPressed: () async {
                        int? val =
                            await push(context, const RouletteScreen(), true);
                        if (val == null) return;
                        push(context, DetailsScreen(res: model.res![val]));
                      },
                    ),
                    SizedBox(width: 8.h),
                    RevButton(
                      'Edit Mystery',
                      buttonColor: AppColors.black,
                      height: 40,
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 12.h),
                            child: Icon(
                              Icons.edit,
                              size: 24.h,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      onPressed: () async {
                        dynamic a =
                            await push(context, const FilterScreen(), true);
                        if (a == null) return;
                        dynamic data = AppCache.getFilter();
                        selectedTypes = data?['category']
                            ?.map<Categories>((e) => Categories.fromJson(e))
                            .toList();
                        setState(() {});
                        model.getAll();
                      },
                    ),
                    SizedBox(width: 8.h),
                    RevButton(
                      'Themed Adventures',
                      buttonColor: AppColors.black,
                      height: 40,
                      icon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 12.h),
                            child: Icon(
                              Icons.tab_unselected,
                              size: 24.h,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.white,
                      borderColor: AppColors.white,
                      onPressed: () async {
                        dynamic theme =
                            await push(context, const AdventuresScreen(), true);
                        if (theme == null) return;
                        await model.getThemed(theme);
                      },
                    ),
                    SizedBox(width: 24.h),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 12.h, left: 24.h),
                child: Row(
                    children: reorderList().map((value) {
                  bool isPresent = selectedTypes.contains(value);
                  return Padding(
                    padding: EdgeInsets.only(right: 12.h),
                    child: InkWell(
                      onTap: () {
                        if (isPresent) {
                          selectedTypes.remove(value);
                        } else {
                          selectedTypes.add(value);
                        }
                        dynamic data = AppCache.getFilter();
                        data?['category'] =
                            selectedTypes.map((e) => e.toJson()).toList();

                        AppCache.setFilter(data);
                        model.getAll();
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(6.h),
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 8.h),
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
                          color: isPresent ? AppColors.primary : AppColors.grey,
                        ),
                      ),
                    ),
                  );
                }).toList()),
              ),
              if (model.busy && model.res != null)
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: SizedBox(
                      height: 2.h, child: const LinearProgressIndicator()),
                ),
              if (model.busy && model.res == null)
                Column(
                  children: [
                    SizedBox(height: 12.h),
                    const HomeShimmer(),
                    const HomeShimmer()
                  ],
                ),
              if (model.res == null && !model.busy && !model.reveal)
                Padding(
                  padding: EdgeInsets.all(80.h),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RevText(
                          '${model.error}',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.grey,
                          bottom: 30.h,
                          align: TextAlign.center,
                        ),
                        RevButton(
                          'Try Again',
                          buttonColor: AppColors.white,
                          height: 40,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.primary,
                          borderColor: AppColors.primary,
                          onPressed: () {
                            model.getAll();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              if (model.res == null && !model.busy && model.reveal)
                Padding(
                  padding: EdgeInsets.all(80.h),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DefaultTextStyle(
                          style: GoogleFonts.inter(
                              fontSize: 70.sp, color: AppColors.primary),
                          child: AnimatedTextKit(
                            pause: const Duration(milliseconds: 100),
                            animatedTexts: [
                              ScaleAnimatedText(
                                'Reveal\nIn',
                                textAlign: TextAlign.center,
                              ),
                              ScaleAnimatedText('3'),
                              ScaleAnimatedText('2'),
                              ScaleAnimatedText('1'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              if (model.res != null && model.res!.isNotEmpty && model.reveal)
                RevText(
                  'Other Offers',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey,
                  left: 24.h,
                  top: 24.h,
                  bottom: 16.h,
                ),
              if (model.res != null && model.reveal)
                model.res!.isEmpty
                    ? Column(
                        children: [
                          RevText(
                            'No restaurant right now\nwith the selected filter',
                            fontSize: 16.sp,
                            align: TextAlign.center,
                            top: 60.h,
                            color: AppColors.grey,
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: model.res!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (_, i) {
                          return RestaurantItem(res: model.res![i]);
                        },
                      )
            ],
          ),
        ),
      ),
    );
  }
}
