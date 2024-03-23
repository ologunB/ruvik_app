import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math';

export 'package:another_flushbar/flushbar.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:collection/collection.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/gestures.dart';
export 'package:flutter/material.dart' hide DatePickerTheme;
export 'package:flutter/services.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:provider/provider.dart';
export 'package:share_plus/share_plus.dart';

export 'base_view.dart';
export 'colors.dart';
export 'money_masked_text.dart';
export 'retry_widget.dart';
export 'rev_back_btn.dart';
export 'rev_button.dart';
export 'rev_field.dart';
export 'rev_progress.dart';
export 'snackbar.dart';
export 'user_image.dart';
export 'utils.dart';

class RevText extends StatelessWidget {
  const RevText(
    this.text, {
    super.key,
    this.color,
    this.letterSpacing,
    this.height,
    this.align,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.fontWeight,
    this.blur = false,
    this.fontSize = 14,
    this.fontFamily,
    this.fontStyle,
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final String? fontFamily;
  final double? letterSpacing;
  final double? height;
  final TextAlign? align;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final bool blur;
  final double top;
  final double bottom;
  final double left;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, right: right, left: left, bottom: bottom),
      child: Text(text,
          textAlign: align,
          maxLines: maxLines,
          overflow: overflow,
          softWrap: true,
          style: GoogleFonts.inter(
            color: color,
            letterSpacing: letterSpacing,
            fontSize: fontSize,
            height: height,
            fontStyle: fontStyle,
            fontWeight: fontWeight,
            decoration: decoration,
          )),
    );
  }
}
