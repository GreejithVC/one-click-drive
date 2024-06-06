import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

///fonts weights
const FontWeight kFW800 = FontWeight.w800;
const FontWeight kFW700 = FontWeight.w700;
const FontWeight kFW600 = FontWeight.w600;
const FontWeight kFW500 = FontWeight.w500;
// const _k500 = FontWeight.w500;
const FontWeight kFW400 = FontWeight.w400;
const FontWeight kFW300 = FontWeight.w300;

class TextPOP36W500 extends StatelessWidget {
  ///heebo Size: 36, Weight: [kFW400], Default Color: AppColors.primary
  const TextPOP36W500(
    this.text, {
    Key? key,
    this.color,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.heebo(
            color: color ?? AppColors.primary,
            fontSize: 36,
            fontWeight: kFW400));
  }
}

class TextPOP28W800 extends StatelessWidget {
  ///heebo Size: 28, Weight: [kFW800], Default Color: AppColors.primary
  const TextPOP28W800(
    this.text, {
    Key? key,
    this.color,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.heebo(
            color: color ?? AppColors.primary,
            fontSize: 28,
            fontWeight: kFW800));
  }
}

class TextPOP26W700 extends StatelessWidget {
  ///heebo Size: 28, Weight: [kFW800], Default Color: AppColors.primary
  const TextPOP26W700(
    this.text, {
    Key? key,
    this.color,
    this.textAlign,
  }) : super(key: key);
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: GoogleFonts.heebo(
            color: color ?? AppColors.primary,
            fontSize: 26,
            fontWeight: kFW700));
  }
}
class TextPOP18W500 extends StatelessWidget {
  ///heebo Size: 14, Weight: [kFW400], Default Color: AppColors.primary
  const TextPOP18W500(
      this.text, {
        Key? key,
        this.color,
        this.height,
        this.textAlign = TextAlign.center,
        this.maxLines,
        this.textDecoration,
      }) : super(key: key);
  final String text;
  final Color? color;
  final int? maxLines;
  final TextAlign textAlign;
  final double? height;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.heebo(
          height: height,
          color: color ?? AppColors.primary,
          fontSize: 18,
          decoration: textDecoration,
          fontWeight: kFW500),
    );
  }
}
class TextINTR14W400 extends StatelessWidget {
  ///heebo Size: 16, Weight: [kFW400], Default Color: AppColors.primary
  const TextINTR14W400(this.text,
      {Key? key, this.color, this.textAlign, this.maxLine, this.style})
      : super(key: key);
  final String text;
  final int? maxLine;
  final Color? color;
  final TextAlign? textAlign;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLine,
      style: GoogleFonts.inter(
          color: color ?? AppColors.primary, fontSize: 14, fontWeight: kFW400),
    );
  }
}

class TextPOP14W400 extends StatelessWidget {
  ///heebo Size: 14, Weight: [kFW400], Default Color: AppColors.primary
  const TextPOP14W400(
    this.text, {
    Key? key,
    this.color,
    this.height,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.textDecoration,
  }) : super(key: key);
  final String text;
  final Color? color;
  final int? maxLines;
  final TextAlign textAlign;
  final double? height;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
      style: GoogleFonts.heebo(
          height: height,
          color: color ?? AppColors.primary,
          fontSize: 14,
          decoration: textDecoration,
          fontWeight: kFW400),
    );
  }
}

class TextPOP12W400 extends StatelessWidget {
  ///heebo Size: 12, Weight: [kFW400], Default Color: AppColors.primary
  const TextPOP12W400(
    this.text, {
    Key? key,
    this.color,
    this.textAlign = TextAlign.center,
    this.maxLines = 1,
    this.textDecoration,
    this.height,
  }) : super(key: key);
  final String text;
  final Color? color;
  final int? maxLines;
  final double? height;
  final TextAlign textAlign;
  final TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.heebo(
          height: height,
          color: color ?? AppColors.primary,
          fontSize: 12,
          decoration: textDecoration,
          decorationThickness: 2.0,
          fontWeight: kFW400),
    );
  }
}
