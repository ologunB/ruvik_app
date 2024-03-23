import 'auto_scroll_text.dart';
import 'rev_text.dart';

class RevButton extends StatelessWidget {
  const RevButton(
    this.text, {
    super.key,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    this.borderColor,
    this.busy = false,
    this.height = 52,
    this.icon,
    this.fontSize,
    this.borderRadius,
    this.safeArea,
    this.fontWeight,
    this.rightIcon,
    this.scroll = false,
  });

  final String text;
  final Function()? onPressed;
  final Color buttonColor;
  final Color textColor;
  final Color? borderColor;
  final bool busy;
  final bool scroll;
  final bool? safeArea;
  final double height;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? icon;
  final Widget? rightIcon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: safeArea ?? true,
      child: SizedBox(
        height: height.h,
        child: TextButton(
          onPressed: (busy || onPressed == null) ? null : onPressed,
          style: TextButton.styleFrom(
            disabledBackgroundColor: Color.lerp(buttonColor, Colors.white, .5),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.circular(borderRadius ?? 6.r),
            ),
            side: (busy || onPressed == null)
                ? null
                : BorderSide(color: borderColor ?? buttonColor),
          ),
          child: busy
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [RevProgress(size: 15.h)],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (icon != null) icon!,
                    scroll
                        ? Expanded(
                            child: AutoScrollText(
                              text,
                              style: TextStyle(
                                color: textColor,
                                fontSize: fontSize,
                                fontWeight: fontWeight,
                              ),
                            ),
                          )
                        : RevText(
                            text,
                            color: textColor,
                            fontSize: fontSize ?? 16.sp,
                            fontWeight: fontWeight ?? FontWeight.w400,
                          ),
                    if (rightIcon != null) rightIcon!,
                  ],
                ),
        ),
      ),
    );
  }
}
