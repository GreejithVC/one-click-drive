import 'dart:math';

import 'package:flutter/material.dart';

import '../constants/app_enums.dart';

class HomeProvider with ChangeNotifier {
  PageStatus _pageStatus = PageStatus.initial;

  PageStatus get pageStatus => _pageStatus;

  set pageStatus(PageStatus newState) {
    _pageStatus = newState;
    notifyListeners();
  }

  final TextEditingController ip1Controller = TextEditingController();
  final TextEditingController ip2Controller = TextEditingController();
  final TextEditingController ip3Controller = TextEditingController();

  Set<int>? intersect;
  Set<int>? union;
  int? highest;

  Future<void> calculate() async {
    Set<int> set1 = ip1Controller.text.split(',').map(int.parse).toSet();
    Set<int> set2 = ip2Controller.text.split(',').map(int.parse).toSet();
    Set<int> set3 = ip3Controller.text.split(',').map(int.parse).toSet();

    intersect = set1.intersection(set2).intersection(set3);
    union = set1.union(set2).union(set3);
    highest = union?.reduce(max);
    notifyListeners();
  }

  void clear() {
    if (intersect != null || union != null || highest != null) {
      intersect = null;
      union = null;
      highest = null;
      notifyListeners();
    }
  }
}
