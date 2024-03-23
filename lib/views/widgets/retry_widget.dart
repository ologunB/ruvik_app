import 'rev_text.dart';

class RetryItem extends StatelessWidget {
  const RetryItem({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(25.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RevText(
            'An error occurred, Do you\nwant to retry?',
            fontSize: 18.sp,
            color: AppColors.red,
            align: TextAlign.center,
            fontWeight: FontWeight.w500,
            bottom: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                child: RevButton(
                  'Retry',
                  buttonColor: Colors.white,
                  height: 50,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  borderRadius: 10.h,
                  onPressed: onTap,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
