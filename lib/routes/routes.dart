import 'package:get/get.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/screen/auth_screen/login_screen/view/login_screen.dart';
import 'package:ingenious_mindslab/screen/auth_screen/signup_screen/view/signup_screen.dart';
import 'package:ingenious_mindslab/screen/details_screen/view/details_screen.dart';
import 'package:ingenious_mindslab/screen/home_screen/view/home_screen.dart';
import 'package:ingenious_mindslab/screen/splash_screen/view/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: login,
      transition: Transition.rightToLeft,
      page: () => const LoginScreen(),
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: singUp,
      transition: Transition.rightToLeft,
      page: () => const SignupScreen(),
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: home,
      transition: Transition.zoom,
      page: () => const HomeScreen(),
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: details,
      transition: Transition.zoom,
      page: () => const DetailsScreen(),
      transitionDuration: const Duration(milliseconds: 400),
    ),
  ];
}
