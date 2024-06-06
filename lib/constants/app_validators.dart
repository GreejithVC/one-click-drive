import 'package:flutter/cupertino.dart';

class AppValidators {


  static FormFieldValidator<String> field = (value) {
    String pattern = r'^[0-9,]*$';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return 'Please fill';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid list of comma-separated numbers';
    }else if (value.endsWith(',')) {
      return 'The last character should not be a comma';
    }
    return null;
  };



}
