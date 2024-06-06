import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';

class AppButton extends StatelessWidget {
  AppButton(
      {Key? key,
      required this.onPressed,
      this.text = 'SUBMIT',
      this.child,
      this.borderRadius,
      this.isSmallButton = false,
      // this.pageStatusProvider,
      this.isLoading = false,
      this.color,
      this.borderColor = false})
      : super(key: key);

  final String text;
  final double? borderRadius;
  final Function onPressed;
  final Widget? child;
  final List<Color>? color;
  bool isLoading;
  final bool borderColor;

  /// To use inside a row enable small button
  final bool isSmallButton;

  @override
  Widget build(BuildContext context) {
    return _button();
  }

  Widget _button() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: color ?? [AppColors.primary, AppColors.primaryDark],
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 26),
          border:
              borderColor ? Border.all(color: Colors.black, width: 1) : null),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minimumSize: const Size(150, 36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : child ??
                Text(
                  text,
                  style: GoogleFonts.lato(
                      fontWeight:
                          isSmallButton ? FontWeight.w500 : FontWeight.w700,color: Colors.white),
                ),
      ),
    );
  }
}
