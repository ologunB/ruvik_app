import 'package:lendo/core/apis/base_api.dart';
import 'package:lendo/core/models/restaurant_model.dart';

import '../widgets/restaurant_item.dart';
import '../widgets/rev_text.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    AppCache.outMainDownloads.listen((_) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<RestaurantModel> res = AppCache.getSavedRestaurants();
    res = res.reversed.toList();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        elevation: 0,
        surfaceTintColor: Colors.white,
        titleSpacing: 4.h,
        title: RevText(
          'Dining History',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.grey,
        ),
        bottom: PreferredSize(
          preferredSize: const Size(0, 1),
          child: Divider(height: 0, thickness: 1.h, color: Colors.black12),
        ),
      ),
      body: res.isEmpty
          ? Center(
              child: RevText(
                'No restaurant has been saved',
                fontSize: 16.sp,
                align: TextAlign.center,
                top: 60.h,
                color: AppColors.grey,
              ),
            )
          : ListView.builder(
              itemCount: res.length,
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 12.h),
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, i) {
                return RestaurantItem(res: res[i]);
              },
            ),
    );
  }
}
