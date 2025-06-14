import 'package:cos_challenge/presentation/screens/login/login_screen.dart';
import 'package:cos_challenge/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String vehicleSearch = '/vehicle-search';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = switch (settings.name) {
      '/splash' => const SplashScreen(),
      '/login' => const LoginScreen(),
      _ => const SizedBox.shrink(),
    };
    return MaterialPageRoute(builder: (context) => route);
  }
}
