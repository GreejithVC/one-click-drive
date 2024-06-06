import 'dart:async';
import 'package:flutter/material.dart';

import '../constants/app_enums.dart';
import '../ui/home/home.dart';

class AppProvider with ChangeNotifier {
  PageStatus _pageStatus = PageStatus.initial;

  PageStatus get pageStatus => _pageStatus;

  set pageStatus(PageStatus newState) {
    _pageStatus = newState;
    notifyListeners();
  }

  void refreshData(BuildContext context) {
    _pageStatus = PageStatus.loading;
    fetchAppDetails(context);
  }

  Future<void> fetchAppDetails(BuildContext context) async {
    _pageStatus = PageStatus.loading;
    await Future.delayed(const Duration(seconds: 3));
    await loadHome(context);
  }

  Future<void> loadHome(BuildContext context) async {
    pageStatus = PageStatus.loaded;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
            (Route<dynamic> route) => false);
  }
}
