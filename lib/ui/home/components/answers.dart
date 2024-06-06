import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../constants/app_styles.dart';
import '../../../constants/app_text.dart';
import '../../../providers/home_provider.dart';

class Answers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<HomeProvider, Tuple3<Set<int>?, Set<int>?, int?>>(
        selector: (buildContext, controller) =>
            Tuple3(controller.intersect, controller.union, controller.highest),
        shouldRebuild: (Tuple3<Set<int>?, Set<int>?, int?> before,
            Tuple3<Set<int>?, Set<int>?, int?> after) {
          return before.item1 != after.item1 || before.item2 != after.item2 ||
              before.item3 != after.item3;
          },
        builder: (context, data, child) {
          print("Builder Called");
          return data.item1 != null && data.item2 != null && data.item3 != null
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStyles.boxHeightMedium,
              TextPOP14W400(
                "1. The intersect of the given numbers?",
                maxLines: 2,
              ),
              AppStyles.boxHeightExtraSmall,
              TextPOP14W400(
                data.item1?.toString() ?? "N/A",
                maxLines: 2,
              ),
              AppStyles.boxHeightMedium,
              TextPOP14W400(
                "2. The union of the given numbers? ",
                maxLines: 2,
              ),
              AppStyles.boxHeightMedium,
              TextPOP14W400(
                data.item2?.toString() ?? "N/A",
                maxLines: 2,
              ),
              AppStyles.boxHeightMedium,
              TextPOP14W400(
                "3. The highest number in all lists? ",
                maxLines: 2,
              ),
              TextPOP14W400(
                data.item3?.toString() ?? "N/A",
                maxLines: 2,
              ),
              AppStyles.boxHeightMedium,
            ],
          )
              : SizedBox.shrink();
        });
  }
}
