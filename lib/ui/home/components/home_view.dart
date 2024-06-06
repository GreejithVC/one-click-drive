import 'package:flutter/material.dart';
import 'package:one_click_drive/constants/app_drawables.dart';
import 'package:one_click_drive/constants/app_text.dart';
import 'package:one_click_drive/widgets/text_fields/custom_text_field.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_enums.dart';
import '../../../constants/app_styles.dart';
import '../../../constants/app_validators.dart';
import '../../../main.dart';
import '../../../providers/home_provider.dart';
import '../../../widgets/button/app_button.dart';
import 'answers.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeProvider homeProvider =
      Provider.of<HomeProvider>(navigatorKey.currentContext!, listen: false);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(gradient: AppStyles.gradientScreen),
      child: Center(
        child: SingleChildScrollView(
          padding: AppStyles.commonScreenAllPadding,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextPOP18W500("RENT A CAR IN DUBAI"),
                AppStyles.boxHeightMedium,
                TextPOP14W400(
                  "Book cars, chauffeurs and yachts – pay zero commission!",
                  maxLines: 2,
                ),
                AppStyles.boxHeightMedium,
                Image.asset(
                  Drawables.logo,
                  height: 100,
                ),
                AppStyles.boxHeightMedium,
                CustomTextField(
                  label: "TextBox1",
                  textInputType: TextInputType.phone,
                  validator: AppValidators.field,
                  textEditingController: homeProvider.ip1Controller,
                  onTextChanged: (val) {
                    homeProvider.clear();
                  },
                ),
                AppStyles.boxHeightMedium,
                CustomTextField(
                  label: "TextBox2",
                  textInputType: TextInputType.phone,
                  validator: AppValidators.field,
                  textEditingController: homeProvider.ip2Controller,
                  onTextChanged: (val) {
                    homeProvider.clear();
                  },
                ),
                AppStyles.boxHeightMedium,
                CustomTextField(
                  label: "TextBox3",
                  textInputType: TextInputType.phone,
                  validator: AppValidators.field,
                  textEditingController: homeProvider.ip3Controller,
                  onTextChanged: (val) {
                    homeProvider.clear();
                  },
                ),
                AppStyles.boxHeightMedium,
                _saveButton(),
                Answers(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _saveButton() {
    return Selector<HomeProvider, PageStatus>(
        selector: (buildContext, controller) => controller.pageStatus,
        builder: (context, data, child) {
          return AppButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  homeProvider.calculate();
                }
              },
              isLoading: data == PageStatus.loading,
              text: "Calculate");
        });
  }
}
