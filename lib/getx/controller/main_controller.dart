import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/utils/common_helpers.dart';
import 'package:ingenious_mindslab/utils/dialog_utils.dart';
import 'package:ingenious_mindslab/utils/firebase_collection_names.dart';
import 'package:ingenious_mindslab/utils/pref_constants.dart';
import 'package:http/http.dart' as http;

class MainController extends GetxController {
  final int seconds = 3;
  RxBool isLoading = false.obs;
  final GetStorage box = GetStorage(); // Initialize GetStorage
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  int batchSize = 100; // Define a batch size

  RxBool obscureSignUpPwdText = true.obs;
  RxBool obscureLoginPwdText = true.obs;
  RxBool obscureConPwdText = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  RxList<DocumentSnapshot>? airPorts = <DocumentSnapshot>[].obs;
  RxBool hasMore = true.obs;
  DocumentSnapshot? lastDocument;

  Future<void> loginUser({required String email, required String pwd}) async {
    try {
      showLoader();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: pwd.trim(),
      );

      if (userCredential.user != null) {
        hideLoader();
        showSuccessSnackBar(
          title: 'Login Successful',
          message: 'Welcome back!',
        );
        box.write(PrefConstants.isUserLoggedIn, true);
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            Get.offAllNamed(home);
          },
        );
      }
    } catch (e) {
      hideLoader();

      showErrorSnackBar(
        title: 'Login Failed',
        message: e.toString(),
      );
    }
  }

  Future<void> registerUser(
      {required String email, required String pwd}) async {
    try {
      showLoader();
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: pwd.trim(),
      );

      if (userCredential.user != null) {
        hideLoader();
        showSuccessSnackBar(
          title: 'Registration Successful',
          message: 'You have successfully registered.',
        );
        box.write(PrefConstants.isUserLoggedIn, true);
        await Future.delayed(
          const Duration(seconds: 1),
          () {
            Get.offAllNamed(home);
          },
        );
      }
    } catch (e) {
      hideLoader();

      showErrorSnackBar(
        title: 'Registration Failed',
        message: e.toString(),
      );
    }
  }

  Future<void> logout(context) async {
    DialogUtils.showAlertDialog(
      context,
      'Do you want to logout?',
      () async {
        try {
          await FirebaseAuth.instance.signOut();
          box.write(PrefConstants.isUserLoggedIn, false);
          Get.offAllNamed(login);
          showSuccessSnackBar(
            title: 'Logged Out',
            message: 'You have been successfully logged out.',
          );
        } catch (e) {
          showErrorSnackBar(
            title: 'Logout Failed',
            message: e.toString(),
          );
        }
      },
    );
  }

  Future<void> seedDataIfNeeded() async {
    var snapShot =
        await _firestore.collection(FirebaseCollection.airPort).limit(1).get();
    if (snapShot.docs.isEmpty) {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        throw Exception('No internet connection. Unable to seed data.');
      }


      var response = await http.get(
        Uri.parse(
            'https://raw.githubusercontent.com/mwgg/Airports/master/airports.json'),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        var dataList = data.values.toList();
        for (int i = 0; i < dataList.length; i += batchSize) {
          int end = (i + batchSize < dataList.length)
              ? i + batchSize
              : dataList.length;
          var batch = dataList.sublist(i, end);
          await _addBatchToFirestore(batch);
        }
      }
    } else {
      fetchAirPorts();
    }
  }

  Future<void> _addBatchToFirestore(batch) async {
    WriteBatch writeBatch = _firestore.batch();

    for (var item in batch) {
      DocumentReference docRef =
          _firestore.collection(FirebaseCollection.airPort).doc();
      writeBatch.set(docRef, item);
    }

    await writeBatch.commit();
  }

  Future<void> fetchAirPorts() async {
    if (isLoading.value || !hasMore.value) return;
    isLoading.value = true;

    try {
      Query query = _firestore
          .collection(FirebaseCollection.airPort)
          .orderBy('name')
          .limit(batchSize);

      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();
      if (querySnapshot.docs.length < batchSize) {
        hasMore.value = false;
      }
      if (querySnapshot.docs.isNotEmpty) {
        lastDocument = querySnapshot.docs.last;
        airPorts?.addAll(querySnapshot.docs);
      }
    } catch (e) {
      showErrorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
