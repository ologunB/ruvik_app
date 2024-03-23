import 'rev_text.dart';

class RevBackButton extends StatelessWidget {
  const RevBackButton({super.key, this.other = true, this.color});

  final bool other;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100.h),
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: const Color(0xffFAFAFA).withOpacity(other ? .1 : 1),
          borderRadius: BorderRadius.circular(100.h),
          border: Border.all(
              width: 2.h,
              color:
                  color ?? const Color(0xffF2F2F2).withOpacity(other ? .1 : 1)),
        ),
        child: Image.asset(
          'left'.png,
          height: 17.h,
          color: color ?? (other ? Colors.white : null),
        ),
      ),
    );
  }
}

class DashedLine extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 10, dashSpace = 10, startX = 0;
    final Paint paint = Paint()
      ..color = const Color(0xffDCDEE0)
      ..strokeWidth = 2.h;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
