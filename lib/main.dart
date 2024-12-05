import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ingenious_mindslab/getx/app_bindings/app_binding.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/screen/splash_screen/ui/splash_screen.dart';
import 'package:ingenious_mindslab/utils/color_constant.dart';

import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
            color: AppColor.whiteColor,
          ),
        ),
      ),
      initialRoute: splash,
      getPages: AppRoutes.pages,
      home: const SplashScreen(),
      initialBinding: AppBinding(),
    );
  }
}
