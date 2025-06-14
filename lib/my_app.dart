import 'package:cos_challenge/core/theme/app_theme.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';
import 'package:cos_challenge/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_cubit.dart';
import 'package:cos_challenge/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarOnSale',
      theme: AppTheme.light,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SplashCubit(
              isUserAuthenticatedUseCase: IsUserAuthenticatedUseCase(
                repository: authRepository,
              ),
            ),
          ),
        ],
        child: Builder(
          builder: (context) {
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
