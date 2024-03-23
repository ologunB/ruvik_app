import 'rev_text.dart';

class RevField extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? labelText;
  final String? hintText;
  final double vertPadding;
  final String? obscuringCharacter;
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool readOnly;
  final bool? enabled;
  final bool validated;
  final bool enableCopy;
  final bool removeBorders;
  final bool obscureText;
  final bool? autoFocus;
  final double? radius;
  final Color? hintColor;
  final Color? textColor;
  final Color? color;
  final FocusNode? focusNode;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;

  const RevField({
    super.key,
    this.prefix,
    this.suffix,
    this.suffixIcon,
    this.validator,
    this.labelText,
    this.textInputAction,
    this.textInputType,
    this.textAlign,
    this.onChanged,
    this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.obscuringCharacter,
    this.maxLines = 1,
    this.onTap,
    this.autoFocus = false,
    this.focusNode,
    this.maxLength,
    this.vertPadding = 10,
    this.enabled,
    this.inputFormatters,
    this.hintColor,
    this.enableCopy = true,
    this.hintText,
    this.color,
    this.textColor,
    this.validated = false,
    this.radius,
    this.onSubmitted,
    this.removeBorders = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          RevText(
            labelText!,
            fontSize: 14.sp,
            bottom: 8.h,
            color: color ?? AppColors.black,
          ),
        SizedBox(
          //   height: maxLines == null ? 40.h : null,
          child: CupertinoTextField(
            suffix: suffix,
            prefix: prefix,
            enableInteractiveSelection: enableCopy,
            cursorColor: AppColors.black,
            cursorWidth: 1.h,
            focusNode: focusNode,
            maxLines: obscureText ? 1 : maxLines,
            autofocus: autoFocus!,
            enabled: enabled ?? true,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            style: GoogleFonts.inter(
              color: AppColors.grey,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            readOnly: readOnly,
            placeholder: hintText,
            placeholderStyle: GoogleFonts.inter(
              color: hintColor ?? const Color(0xFF9E9E9E),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            padding:
                EdgeInsets.symmetric(horizontal: 8.h, vertical: vertPadding.h),
            decoration: BoxDecoration(
              border: Border.all(width: 1.h, color: const Color(0xffCDD1E0)),
              borderRadius: BorderRadius.circular(6.h),
              color: Colors.white,
            ),
            onTap: onTap,
            obscureText: obscureText,
            obscuringCharacter: '●',
            controller: controller,
            textAlign: textAlign ?? TextAlign.start,
            keyboardType: textInputType,
            onChanged: onChanged,
            onTapOutside: (a) {
              Utils.offKeyboard();
            },
          ),
        )
      ],
    );
  }
}
