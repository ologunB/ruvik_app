import 'rev_text.dart';

class RevProgress extends StatelessWidget {
  const RevProgress({this.size = 20, super.key, this.text});

  final double size;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.h,
          width: size.h,
          child: CircularProgressIndicator(
            strokeWidth: 3.h,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
          ),
        ),
        SizedBox(height: 10.h),
        if (text != null)
          RevText(
            '$text',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: Colors.black,
          ),
      ],
    );
  }
}

class HexError extends StatelessWidget {
  const HexError({this.size = 20, super.key, this.text});

  final double size;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline_outlined, color: AppColors.red, size: 34.h),
        SizedBox(height: 10.h),
        if (text != null)
          RevText(
            '$text',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            align: TextAlign.center,
            color: AppColors.red,
          ),
      ],
    );
  }
}
