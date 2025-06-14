import 'package:cos_challenge/core/constants/app_routes.dart';
import 'package:cos_challenge/core/constants/images_paths.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_cubit.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: context.read<SplashCubit>()..checkUserAuthentication(),
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.vehicleSearch);
        } else if (state is SplashUnauthenticated) {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      },
      child: Scaffold(
        body: Center(
          child: SvgPicture.asset(ImagesPaths.logo, height: 150, width: 150),
        ),
      ),
    );
  }
}
