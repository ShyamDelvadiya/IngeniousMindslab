import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

class HomeListView extends StatelessWidget {
  const HomeListView(
      {super.key, required this.controller, required this.scrollController});

  final MainController controller;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value &&
          (controller.airPorts?.isEmpty ?? false)) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        controller: scrollController,
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
                    color: AppColor.whiteColor, fontWeight: FontWeight.bold),
                subtitleTextStyle: TextStyle(
                  color: AppColor.whiteColor.withOpacity(.7),
                ),
                subtitle: Text('${airport['city'] ?? ''}(${airport['country']})'),
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
    });
  }
}
