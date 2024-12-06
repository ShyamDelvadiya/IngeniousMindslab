import 'package:flutter/material.dart';
import 'package:ingenious_mindslab/common_widgets/common_bottom_background.dart';
import 'package:ingenious_mindslab/common_widgets/common_home_background.dart';
import 'package:ingenious_mindslab/screen/auth_screen/login_screen/widget/login_container.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _mainView(context);
  }

  Widget _mainView(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
        LoginContainer()
      ],
    );
  }
}
