import 'package:flutter/material.dart';

import '../../constants/app_drawables.dart';

class CustomLoader extends StatelessWidget {

  const CustomLoader({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 200,
        child: Image.asset(Drawables.appLoading,
            fit: BoxFit.contain));
  }
}
