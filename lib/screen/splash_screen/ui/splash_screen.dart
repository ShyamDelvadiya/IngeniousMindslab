import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/common_widgets/common_bottom_background.dart';
import 'package:ingenious_mindslab/common_widgets/common_home_background.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';
import 'package:ingenious_mindslab/utils/image_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final MainController controller = Get.find<MainController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _routeToLoginScreen();
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  _mainView() {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColor.blackColor,
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: [
        const CommonHomeBackground(),
        const CommonBottomBackground(),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Images.splashImg,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _routeToLoginScreen() async {
    await Future.delayed(
      Duration(seconds: controller.seconds),
      () {
        Get.offAllNamed(login);
      },
    );
  }
}
