import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/app_colors.dart';
import 'shadow input_border.dart';

enum TextFieldType { none, underline, outlined, labelOutside, card, search }

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {Key? key,
      this.hint,
      required this.label,
      this.subLabel,
      this.prefixIconData,
      required this.textEditingController,
      this.minLines = 1,
      this.maxLines = 1,
      this.textInputType,
      this.validator,
      this.contentPadding,
      this.isRequiredField = true,
      this.inputFormatters = const [],
      this.autoValidate = false,
      this.maxLength,
      this.suffixIcon,
      this.isPassword = false,
      this.backendValidation,
      this.autoFillHints,
      this.isLabelBold = false,
      this.disableOnlyTyping = false,
      this.textFieldType = TextFieldType.outlined,
      this.onChanged,
      this.prefixIconColor,
      this.fillColor = Colors.transparent,
      this.labelColor = Colors.white,
      this.borderColor,
      this.readOnly = false,
      this.onTextChanged,
      this.onTypingHideFabButton = true,
      this.expand = false,
      this.textCapitalization = TextCapitalization.none,
      this.hintColor = Colors.white,
      this.textColor = Colors.white,
      this.borderRadius,
      this.cursorColor = Colors.white})
      : super(key: key);

  final String label;
  final String? subLabel;
  final bool isRequiredField;
  final String? hint;
  final int minLines, maxLines;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIconData;
  final Color? prefixIconColor;
  final Color fillColor;
  final Color labelColor;
  final Color? borderColor;
  final Color? hintColor;
  final Color? cursorColor;
  final Color? textColor;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter> inputFormatters;
  final TextFieldType textFieldType;
  final bool isLabelBold;
  final bool disableOnlyTyping;

  final bool autoValidate;
  final int? maxLength;
  final Widget? suffixIcon;
  final bool isPassword;
  final Future<String?> Function()? backendValidation;
  final Function(String)? onChanged;
  final List<String>? autoFillHints;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onTextChanged;
  final bool expand;
  final double? borderRadius;

  final bool onTypingHideFabButton;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isTextVisible = true;
  String? errorText;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isTextVisible = !widget.isPassword;
    if (widget.backendValidation != null) {
      _focusNode.addListener(() async {
        if (!_focusNode.hasFocus) {
          if (widget.validator != null &&
              widget.validator!(widget.textEditingController.text) == null) {
            errorText = await widget.backendValidation!();
            if (mounted) {
              setState(() {});
            }
          }
        } else {
          errorText = null;
          if (mounted) {
            setState(() {});
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ([TextFieldType.card, TextFieldType.labelOutside]
            .contains(widget.textFieldType))
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              getLabel(
                  label: widget.label,
                  labelColor: widget.labelColor,
                  subLabel: widget.subLabel,
                  isRequiredField: widget.isRequiredField,
                  isLabelBold: widget.isLabelBold),
              const SizedBox(
                height: 2,
              ),
            ],
          ),
        Padding(
          padding: TextFieldType.card == widget.textFieldType
              ? const EdgeInsets.all(1)
              : EdgeInsets.zero,
          child: TextFormField(
            readOnly: widget.readOnly,
            textCapitalization: widget.textCapitalization,
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            style: GoogleFonts.heebo(color: widget.textColor ?? Colors.black, fontSize: 15),
            validator:
                errorText != null ? (value) => errorText : widget.validator,
            // focusNode: _focusNode,
            autovalidateMode: widget.autoValidate
                ? AutovalidateMode.always
                : AutovalidateMode.onUserInteraction,
            inputFormatters: widget.inputFormatters,
            minLines: widget.minLines,
            maxLines:
                !widget.expand ? max(widget.maxLines, widget.minLines) : null,
            maxLength: widget.maxLength,
            obscureText: !isTextVisible,
            autofillHints: widget.autoFillHints,
            onChanged: widget.onTextChanged,
            cursorColor: widget.cursorColor ?? Colors.black,
            enableInteractiveSelection: !widget.disableOnlyTyping,
            // will disable paste operation
            focusNode: widget.disableOnlyTyping
                ? AlwaysDisabledFocusNode()
                : _focusNode,
            decoration: CustomInputDecoration(
              contentPadding: widget.contentPadding,
              borderColor: widget.borderColor,
              labelColor: widget.labelColor,
              fillColor: widget.fillColor,
              hintColor: widget.hintColor,
              label: widget.label,
              subLabel: widget.subLabel,
              isLabelBold: widget.isLabelBold,
              hintText: widget.hint,
              errorText: errorText,
              textFieldType: widget.textFieldType,
              borderRadius: widget.borderRadius,
              prefixIcon: widget.prefixIconData != null
                  ? Icon(
                      widget.prefixIconData,
                      color: widget.prefixIconColor ?? Colors.grey,
                    )
                  : null,
              isRequiredField: widget.isRequiredField,
              suffixIcon: widget.isPassword
                  ? isTextVisible
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              isTextVisible = !isTextVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility,
                              color: AppColors.appButtonPrimary),
                        )
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              isTextVisible = !isTextVisible;
                            });
                          },
                          icon: const Icon(Icons.visibility_off,
                              color: AppColors.appButtonPrimary))
                  : widget.suffixIcon,
            ),
          ),
        ),
      ],
    );
  }
}

class CustomInputDecoration extends InputDecoration {
  CustomInputDecoration(
      {required String label,
      String? subLabel,
      required bool isRequiredField,
      required bool isLabelBold,
      EdgeInsetsGeometry? contentPadding,
      String? hintText,
      String? errorText,
      Widget? prefixIcon,
      TextFieldType textFieldType = TextFieldType.none,
      Widget? suffixIcon,
      Color? fillColor,
      Color? hintColor,
      Color? borderColor,
      Color? labelColor,
      double? borderRadius})
      : super(
          label: [
            TextFieldType.outlined,
            TextFieldType.underline,
            TextFieldType.none
          ].contains(textFieldType)
              ? getLabel(
                  label: label,
                  labelColor: labelColor,
                  subLabel: subLabel,
                  isRequiredField: isRequiredField,
                  isLabelBold: isLabelBold)
              : null,
          hintText: hintText,
          fillColor: fillColor,
          hintStyle: GoogleFonts.heebo(color: hintColor, fontSize: 13),
          filled: true,
          counterText: '',
          errorText: errorText,
          alignLabelWithHint: false,
          // isDense: true,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          border: getBorder(textFieldType,
              borderColor: borderColor, borderRadius: borderRadius),
          errorBorder: getBorder(textFieldType, borderRadius: borderRadius),
          focusedBorder: getBorder(textFieldType,
              isFocusBorder: true,
              borderColor: borderColor,
              borderRadius: borderRadius),
          focusedErrorBorder: getBorder(textFieldType,
              isFocusBorder: true, borderRadius: borderRadius),
          enabledBorder: getBorder(textFieldType,
              borderColor: borderColor, borderRadius: borderRadius),
          disabledBorder: getBorder(textFieldType, borderRadius: borderRadius),
        );
}

RichText getLabel(
    {required String label,
    String? subLabel,
    Color? labelColor,
    bool isRequiredField = true,
    required bool isLabelBold}) {
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      text: label,
      style: GoogleFonts.heebo(
          color: labelColor ?? Colors.grey.withOpacity(0.7),
          fontSize: 12,
          fontWeight: isLabelBold ? FontWeight.w700 : FontWeight.w400,
          height: 1),
      children: [
        if (isRequiredField)
          TextSpan(
            text: ' *',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: labelColor ?? Colors.grey),
          ),
        if (subLabel != null)
          TextSpan(
            text: ' ($subLabel)',
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey),
          ),
      ],
    ),
  );
}

InputBorder getBorder(TextFieldType textFieldType,
    {bool isFocusBorder = false, Color? borderColor, double? borderRadius}) {
  return textFieldType == TextFieldType.none
      ? InputBorder.none
      : textFieldType == TextFieldType.underline
          ? UnderlineInputBorder(
              borderSide:
                  BorderSide(width: 1, color: borderColor ?? AppColors.primary),
            )
          : TextFieldType.card == textFieldType
              ? ShadowedInputBorder(
                  child: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                        width: 1, color: AppColors.appButtonLightGreyColor),
                  ),
                  shadow: const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                )
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  borderSide: BorderSide(
                      width: 1, color: borderColor ?? AppColors.primary),
                );
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
