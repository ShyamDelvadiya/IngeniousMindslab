import 'package:get/get.dart';
import 'package:ingenious_mindslab/routes/routes_path.dart';
import 'package:ingenious_mindslab/screen/auth_screen/login_screen/screen/login_screen.dart';
import 'package:ingenious_mindslab/screen/auth_screen/signup_screen/screen/signup_screen.dart';
import 'package:ingenious_mindslab/screen/splash_screen/ui/splash_screen.dart';

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
      transitionDuration: const Duration(milliseconds: 600),
    ),  GetPage(
      name: singUp,
      transition: Transition.rightToLeft,
      page: () => const SignupScreen(),
      transitionDuration: const Duration(milliseconds: 600),
    ),
  ];
}
