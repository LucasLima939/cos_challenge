import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/presentation/screens/login/login_screen.dart';
import 'package:cos_challenge/presentation/screens/splash/splash_screen.dart';
import 'package:cos_challenge/presentation/screens/vehicle_details/vehicle_details_screen.dart';
import 'package:cos_challenge/presentation/screens/vehicle_search/vehicle_search_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  const AppRoutes._();

  static const String splash = '/splash';
  static const String login = '/login';
  static const String vehicleSearch = '/vehicle-search';
  static const String vehicleDetails = '/vehicle-details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = switch (settings.name) {
      '/splash' => const SplashScreen(),
      '/login' => const LoginScreen(),
      '/vehicle-search' => const VehicleSearchScreen(),
      '/vehicle-details' => VehicleDetailsScreen(
        vehicle: settings.arguments as VehicleModel,
      ),
      _ => const SizedBox.shrink(),
    };
    return MaterialPageRoute(builder: (context) => route);
  }
}
