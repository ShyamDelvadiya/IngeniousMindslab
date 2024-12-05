import 'package:flutter/material.dart';
import 'package:ingenious_mindslab/common_widgets/common_bottom_background.dart';
import 'package:ingenious_mindslab/common_widgets/common_home_background.dart';
import 'package:ingenious_mindslab/screen/auth_screen/login_screen/widget/login_container.dart';
import 'package:ingenious_mindslab/screen/auth_screen/signup_screen/widgets/signup_container.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  Widget _mainView() {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
      body: _body(context),
    );
  }

  Widget _body(context) {
    return const Stack(
      children: [
        CommonHomeBackground(),
        CommonBottomBackground(),
        SignupContainer()
      ],
    );
  }
}
