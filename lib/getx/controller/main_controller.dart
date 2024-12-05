import 'package:get/get.dart';

class MainController extends GetxController {
  final int seconds = 3;

  RxBool obscurePwdText = false.obs;
  RxBool obscureConPwdText = true.obs;
}
