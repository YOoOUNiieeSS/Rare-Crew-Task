
import 'package:flutter/material.dart';
import 'package:rare_crew_test/features/home_screen/view/screens/home_page_screen.dart';
import 'package:rare_crew_test/features/login/views/screens/login_screen.dart';
import 'package:rare_crew_test/features/login/views/screens/sign_up.dart';
import 'package:rare_crew_test/features/splash/splash_screen.dart';
import 'package:rare_crew_test/shared_resources/string_manager.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String signup = '/signup';
  static const String homeScreen = '/homeScreen';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen(),);
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen(),);
      case Routes.signup:
        return MaterialPageRoute(builder: (context) => const SignUpScreen(),);
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen(),);
        default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(StringManager.undefinedRoute)),
              body: const Center(child: Text(StringManager.undefinedRoute)),
            ));
  }
}
