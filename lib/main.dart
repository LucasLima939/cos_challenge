import 'package:cos_challenge/core/constants/app_routes.dart';
import 'package:cos_challenge/core/theme/app_theme.dart';
import 'package:cos_challenge/injection_container.dart';
import 'package:cos_challenge/presentation/cubits/login/login_cubit.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_cubit.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_cubit.dart';
import 'package:cos_challenge/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initContainer();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SplashCubit>()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<VehicleSearchCubit>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarOnSale',
      theme: AppTheme.light,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: const SplashScreen(),
    );
  }
}
