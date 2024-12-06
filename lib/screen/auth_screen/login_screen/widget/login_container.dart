import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/common_widgets/common_button.dart';
import 'package:ingenious_mindslab/common_widgets/common_textfield.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';
import 'package:ingenious_mindslab/utils/size_constant.dart';
import 'package:ingenious_mindslab/utils/string_constants.dart';

class LoginContainer extends StatelessWidget {
  const LoginContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final MainController controller = Get.find<MainController>();
    final formKey = GlobalKey<FormState>();

    return Padding(
      padding: const EdgeInsets.only(
        left: PaddingConstant.maximumPadding,
        right: PaddingConstant.maximumPadding,
      ),
      child: Form(
        key: formKey,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                    left: PaddingConstant.mainPagePadding,
                    top: 0,
                    right: PaddingConstant.mainPagePadding),
                child: Text(
                  StringConstant.login,
                  style: TextStyle(
                      fontSize: FontConstant.maxBigFont,
                      fontWeight: FontWeight.bold,
                      color: AppColor.whiteColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: PaddingConstant.mainPagePadding,
                    top: PaddingConstant.medium25Padding,
                    right: PaddingConstant.mainPagePadding),
                child: Center(
                  child: CustomTextFormField(
                      hintText: StringConstant.emailHintTxt,
                      controller: controller.loginEmailController,
                      fillColorBool: true,
                      fillColor: AppColor.suggestionColor2,
                      hintstyle: const TextStyle(color: AppColor.grey),
                      isEmail: true,
                      textInputType: TextInputType.emailAddress),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingConstant.mainPagePadding,
                  bottom: 0,
                  top: PaddingConstant.maximumPadding,
                  right: PaddingConstant.mainPagePadding,
                ),
                child: Obx(() => CustomTextFormField(
                      obscureText: controller.obscureLoginPwdText.value,
                      fillColorBool: true,
                      fillColor: AppColor.suggestionColor2,
                      suffixImage: GestureDetector(
                        onTap: () {
                          controller.obscureLoginPwdText.value =
                              !controller.obscureLoginPwdText.value;
                        },
                        child: Icon(
                          controller.obscureLoginPwdText.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColor.whiteColor,
                        ),
                      ),
                      hintstyle: const TextStyle(color: AppColor.grey),
                      hintText: StringConstant.passwordHintTxt,
                      isPassword: true,
                      controller: controller.loginPasswordController,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: PaddingConstant.mainPagePadding,
                    top: PaddingConstant.extraMaximum50Padding,
                    right: PaddingConstant.mainPagePadding),
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      controller.loginUser(
                        email: controller.loginEmailController.text,
                        pwd: controller.loginPasswordController.text,
                      );
                    }
                  },
                  text: StringConstant.login,
                ),
              ),
              PaddingConstant.verticalSpace(
                  height: PaddingConstant.mediumPadding),
              GestureDetector(
                onTap: () {
                  Get.toNamed(singUp);
                },
                child: const Center(
                  child: Text(
                    'Register a new account?\n click here',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: FontConstant.headingFont),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
