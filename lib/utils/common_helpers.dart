import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Timer? _debounceTimer;

void timerCommonFunction(String val, Function() onComplete) {
  // widget.overrideMrpPriceController.clear();

  if (_debounceTimer != null && _debounceTimer!.isActive) {
    _debounceTimer!.cancel();
  }
  _debounceTimer = Timer(const Duration(milliseconds: 500), () {
    if (val.isEmpty) {
      onComplete();
    } else {
      // widget.overrideBasePriceOnChanged?.call(amount, 'N');
      onComplete();
    }
  });
}

showLoader() {
  Get.dialog(
    Center(
      child: LoadingAnimationWidget.staggeredDotsWave(
        color: AppColor.whiteColor,
        size: 50,
      ),
    ),
    barrierDismissible: true,
  );
}

hideLoader() {
  Get.back();
}

showSuccessSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColor.greenColor,
    colorText: AppColor.whiteColor,
  );
}

showErrorSnackBar({required String title, required String message}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: AppColor.redColor,
    colorText: AppColor.whiteColor,
  );
}

String handleFirebaseAuthError(FirebaseAuthException e) {
  switch (e.code) {
    case 'invalid-email':
      return 'The email address is not valid. Please check and try again.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'user-not-found':
      return 'No user found with this email. Please register first.';
    case 'wrong-password':
      return 'The password is incorrect. Please check and try again.';
    case 'too-many-requests':
      return 'Too many attempts have been made. Please try again later.';
    default:
      return 'An unknown error occurred. Please try again.';
  }
}
