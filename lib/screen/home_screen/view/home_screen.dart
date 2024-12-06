import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/common_widgets/common_bottom_background.dart';
import 'package:ingenious_mindslab/common_widgets/common_home_background.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainController controller = Get.find<MainController>();

  final ScrollController _scrollController = ScrollController();

  final List<DocumentSnapshot> airports = [];
  bool isLoading = false;
  bool hasMore = true;
  DocumentSnapshot? _lastDocument;

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

    // Add listener to the scroll controller for pagination
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.whiteColor.withOpacity(.3),
        onPressed: () {
          controller.logout(context);
        },
        child: const Icon(
          Icons.login_outlined,
        ),
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: [
        const CommonHomeBackground(),
        const CommonBottomBackground(),
        Obx(() {
          if (controller.isLoading.value &&
              (controller.airPorts?.isEmpty ?? false)) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: (controller.airPorts?.length ?? 0) +
                (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.airPorts?.length) {
                return const Center(child: CircularProgressIndicator());
              }

              var airport =
                  controller.airPorts?[index].data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppColor.whiteColor.withOpacity(.1),
                  child: ListTile(
                    title: Text(airport['name'] ?? 'Unknown'),
                    titleTextStyle: const TextStyle(
                        color: AppColor.whiteColor,
                        fontWeight: FontWeight.bold),
                    subtitleTextStyle: TextStyle(
                      color: AppColor.whiteColor.withOpacity(.7),
                    ),
                    subtitle: Text(airport['city'] ?? ''),
                    trailing: const Icon(
                      Icons.navigate_next,
                      color: AppColor.whiteColor,
                    ),
                    onTap: () {
                      Get.toNamed(details, arguments: {
                        'airPorts': airport,
                      });
                    },
                  ),
                ),
              );
            },
          );
        })
      ],
    );
  }
}
