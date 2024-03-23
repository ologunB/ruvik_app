import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lendo/core/models/restaurant_model.dart';
import 'package:lendo/views/widgets/rev_text.dart';

import '../home/details.dart';
import 'cached_image.dart';

class RestaurantItem extends StatelessWidget {
  const RestaurantItem({super.key, required this.res});
  final RestaurantModel res;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: () {
          push(context, DetailsScreen(res: res, splash: false));
        },
        splashColor: Colors.white,
        highlightColor: Colors.white,
        borderRadius: BorderRadius.circular(6.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200.h,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.h),
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Color(0xff280E40)],
                        stops: [0.0, 1.0],
                      ).createShader(bounds),
                      blendMode: BlendMode.srcATop,
                      child: SizedBox(
                        height: 200.h,
                        width: MediaQuery.of(context).size.width,
                        child: RevCachedImage(url: res.imageUrl!),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.h),
                        child: Row(
                          children: [
                            RatingBarIndicator(
                              rating: res.rating!,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 14.sp,
                            ),
                            RevText(
                              '(${res.reviewCount})',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      RevText(
                        '${res.name}',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        bottom: 12.h,
                        left: 12.h,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('loc'.png, height: 16.h),
                          Expanded(
                            child: RevText(
                              '${res.location?.displayAddress?.join(', ')}',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey2,
                              left: 6.h,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      RevText(
                        'Cuisines: ${res.categories?.map((e) => e.title).join(', ')}'
                            .toTitleCase(),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey2,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6.h),
                Image.asset('go'.png, height: 40.h)
              ],
            ),
            SizedBox(height: 6.h),
            if (res.transactions!.isNotEmpty)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children: res.transactions!
                        .map((e) => CustomChip(title: e))
                        .toList()),
              ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  const CustomChip({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 6.h),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(20.h)),
      child: RevText(
        title.toTitleCase(),
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.grey2,
        left: 6.h,
      ),
    );
  }
}
