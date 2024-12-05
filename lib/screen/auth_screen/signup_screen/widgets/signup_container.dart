import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/common_widgets/common_button.dart';
import 'package:ingenious_mindslab/common_widgets/common_textfield.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';
import 'package:ingenious_mindslab/utils/common_validators.dart';
import 'package:ingenious_mindslab/utils/size_constant.dart';
import 'package:ingenious_mindslab/utils/string_constants.dart';

class SignupContainer extends StatefulWidget {
  const SignupContainer({super.key});

  @override
  State<SignupContainer> createState() => _SignupContainerState();
}

class _SignupContainerState extends State<SignupContainer> {
  final formKey = GlobalKey<FormState>();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reEnterPasswordController = TextEditingController();
  final MainController controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
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
                  StringConstant.signUp,
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
                    controller: mobileNumberController,
                    fillColorBool: true,
                    fillColor: AppColor.suggestionColor2,
                    hintstyle: const TextStyle(color: AppColor.grey),
                    isEmail: true,
                    textInputType: TextInputType.emailAddress,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingConstant.mainPagePadding,
                  bottom: 0,
                  top: PaddingConstant.maximumPadding,
                  right: PaddingConstant.mainPagePadding,
                ),
                child: Obx(() {
                  return CustomTextFormField(
                    obscureText: controller.obscurePwdText.value,
                    fillColorBool: true,
                    fillColor: AppColor.suggestionColor2,
                    suffixImage: GestureDetector(
                      onTap: () {
                        controller.obscurePwdText.value =
                            !controller.obscurePwdText.value;
                      },
                      child: Icon(
                        controller.obscurePwdText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    hintstyle: const TextStyle(color: AppColor.grey),
                    hintText: StringConstant.passwordHintTxt,
                    isPassword: true,
                    controller: passwordController,
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: PaddingConstant.mainPagePadding,
                  bottom: 0,
                  top: PaddingConstant.maximumPadding,
                  right: PaddingConstant.mainPagePadding,
                ),
                child: Obx(() {
                  return CustomTextFormField(
                    obscureText: controller.obscureConPwdText.value,
                    fillColorBool: true,
                    fillColor: AppColor.suggestionColor2,
                    suffixImage: GestureDetector(
                      onTap: () {
                        controller.obscureConPwdText.value =
                            !controller.obscureConPwdText.value;
                      },
                      child: Icon(
                        controller.obscureConPwdText.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColor.whiteColor,
                      ),
                    ),
                    hintstyle: const TextStyle(color: AppColor.grey),
                    hintText: StringConstant.confirmPasswordHintTxt,
                    isConfirmPassword: true,
                    validator: (value) => CommonValidators.confirmPassword(
                        value, passwordController.text),
                    password: passwordController.text,
                    controller: reEnterPasswordController,
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: PaddingConstant.mainPagePadding,
                    top: PaddingConstant.extraMaximum50Padding,
                    right: PaddingConstant.mainPagePadding),
                child: CustomButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {}
                  },
                  text: StringConstant.signUp,
                ),
              ),
              PaddingConstant.verticalSpace(
                  height: PaddingConstant.mediumPadding),
            ],
          ),
        ),
      ),
    );
  }
}
