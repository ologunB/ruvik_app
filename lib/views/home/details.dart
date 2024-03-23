import 'package:confetti/confetti.dart';
import 'package:lendo/views/widgets/cached_image.dart';
import 'package:lendo/views/widgets/rev_text.dart';

import '../../core/apis/local_storage.dart';
import '../../core/models/restaurant_model.dart';
import '../../core/vms/restaurants_vm.dart';
import '../widgets/restaurant_item.dart';
import 'home.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.res, this.splash = true});
  final RestaurantModel res;
  final bool splash;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late RestaurantModel res;
  @override
  void initState() {
    res = widget.res;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.splash) {
        AppCache.setSavedRestaurants(res);
        confettiController.play();
      }
    });
    super.initState();
  }

  final ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 7));
  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var message = " I want to buy food";
    Widget action(String name, Function() fn) => InkWell(
          borderRadius: BorderRadius.circular(40.h),
          onTap: fn,
          child: Image.asset(name.png, height: 40.h),
        );
    return ConfettiWidget(
      confettiController: confettiController,
      blastDirectionality: BlastDirectionality.explosive, // radial value
      shouldLoop: false, // continuous emission
      colors: const [
        Colors.green,
        Colors.blue,
        Colors.pink,
        Colors.orange,
        Colors.purple
      ],
      child: BaseView<RestaurantsViewModel>(
          onModelReady: (a) => a.getDetails(res.id),
          builder: (_, uModel, __) {
            if (uModel.restaurant != null) res = uModel.restaurant!;
            return Scaffold(
              backgroundColor: AppColors.white,
              bottomNavigationBar: SafeArea(
                top: false,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.h, vertical: 10.h),
                  child: const CupertinoTextField(
                    placeholder: 'Write your review',
                  ),
                ),
              ),
              body: RefreshIndicator(
                onRefresh: () async {
                  uModel.getDetails(res.id);
                  return;
                },
                color: AppColors.primary,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 350.h,
                          width: MediaQuery.of(context).size.width,
                          child: RevCachedImage(url: res.imageUrl!),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 24.h, vertical: 16.h),
                          child: SafeArea(
                            child: Row(
                              children: [
                                action('back', () => Navigator.pop(context)),
                                const Spacer(),
                                action('share', () => Share.share(message)),
                                /*   SizedBox(width: 8.h),
                          action('like', () {}),*/
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 24.h),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RevText(
                                '${res.name}',
                                fontSize: 24.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColors.grey,
                                bottom: 8.h,
                                top: 16.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset('loc'.png, height: 16.h),
                                  Expanded(
                                    child: RevText(
                                      '${res.location?.displayAddress?.join(', ')}',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.grey2,
                                      left: 6.h,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                            ],
                          ),
                        ),
                        SizedBox(width: 8.h),
                        Icon(Icons.star_rounded,
                            color: Colors.yellow, size: 22.h),
                        RevText(
                          '${res.rating}',
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          left: 4.h,
                        ),
                        SizedBox(width: 24.h),
                      ],
                    ),
                    RevText(
                      'Category: ${res.categories?.map((e) => e.title).join(', ')}'
                          .toTitleCase(),
                      fontSize: 13.sp,
                      right: 24.h,
                      top: 8.h,
                      left: 24.h,
                      bottom: 12.h,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey2,
                    ),
                    if (res.transactions!.isNotEmpty)
                      SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: res.transactions!
                                .map((e) => CustomChip(title: e))
                                .toList()),
                      ),
                    if (res.hours != null)
                      RevText(
                        'Open By:',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        left: 24.h,
                        top: 12.h,
                      ),
                    if (res.hours != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: res.hours!.first.open!.map((value) {
                            return Container(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RevText(
                                      [
                                        'Sunday',
                                        'Monday',
                                        'Tuesday',
                                        'Wednesday',
                                        'Thursday',
                                        'Friday',
                                        'Saturday'
                                      ][value.day!],
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.access_time_sharp,
                                          size: 20.h,
                                        ),
                                        RevText(
                                          'Opens: ${value.start?.colon()} - Closes: ${value.end?.colon()}',
                                          fontSize: 12.sp,
                                          left: 4.h,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.grey2,
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                          }).toList(),
                        ),
                      ),
                    Reviews(id: res.id)
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class Reviews extends StatelessWidget {
  const Reviews({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return BaseView<RestaurantsViewModel>(
      onModelReady: (a) => a.getReviews(id),
      builder: (_, model, __) {
        return ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            RevText(
              'Reviews',
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              left: 24.h,
              top: 12.h,
            ),
            if (model.busy && model.reviews == null)
              Column(
                children: [
                  SizedBox(height: 12.h),
                  SizedBox(height: 70.h, child: const HomeShimmer()),
                  SizedBox(height: 70.h, child: const HomeShimmer()),
                  SizedBox(height: 70.h, child: const HomeShimmer())
                ],
              ),
            if (model.reviews == null && !model.busy)
              Padding(
                padding: EdgeInsets.all(40.h),
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
            if (!model.busy && model.reviews != null)
              ListView.builder(
                itemCount: model.reviews!.length,
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                physics: const ClampingScrollPhysics(),
                itemBuilder: (_, i) {
                  ReviewModel rev = model.reviews![i];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: RevCachedImage(
                        url: rev.user!.imageUrl!,
                        height: 50.h,
                        width: 50.h,
                      ),
                    ),
                    title: RevText(
                      '${rev.user?.name}  -  ${rev.timeCreated?.split(' ').first}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.grey2,
                    ),
                    subtitle: RevText(
                      rev.text!,
                      fontSize: 16.sp,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              )
          ],
        );
      },
    );
  }
}
