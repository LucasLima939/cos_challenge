import 'package:cos_challenge/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;

  SplashCubit({required this.isUserAuthenticatedUseCase})
    : super(SplashInitial());

  Future<void> checkUserAuthentication() async {
    try {
      final isAuthenticated = await isUserAuthenticatedUseCase.call(null);
      if (isAuthenticated) {
        emit(SplashAuthenticated());
        return;
      }
    } catch (_) {}
    emit(SplashUnauthenticated());
  }
}
