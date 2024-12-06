import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/common_widgets/common_bottom_background.dart';
import 'package:ingenious_mindslab/common_widgets/common_home_background.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/screen/home_screen/widget/home_list_view.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController controller = Get.find<MainController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.seedDataIfNeeded();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller
            .fetchAirPorts(); // Fetch more data when scrolled to the bottom
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _mainView();
  }

  Widget _mainView() {
    return Scaffold(
      backgroundColor: AppColor.blackColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      floatingActionButton: _floatingActionButton(),
      body: _body(context),
    );
  }

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: AppColor.whiteColor.withOpacity(.3),
      onPressed: () {
        controller.logout(context);
      },
      child: const Icon(
        Icons.login_outlined,
      ),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: [
        const CommonHomeBackground(),
        const CommonBottomBackground(),
        HomeListView(
          controller: controller,
          scrollController: _scrollController,
        )
      ],
    );
  }
}
