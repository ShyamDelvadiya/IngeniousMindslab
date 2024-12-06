import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ingenious_mindslab/getx/controller/main_controller.dart';

class AppBinding extends Bindings {
  AppBinding();

  @override
  void dependencies() {
    // ignore: todo
    // TODO: implement dependencies
    Get.put(GetStorage());
    Get.put(MainController());
  }
}
