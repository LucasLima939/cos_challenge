import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:cos_challenge/domain/use_cases/register_user_use_case.dart';
import 'package:cos_challenge/presentation/cubits/login/login_state.dart';
import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  final RegisterUserUseCase registerUseCase;

  LoginCubit({required this.registerUseCase}) : super(const LoginInitial());

  Future<void> login(String email, String password) async {
    try {
      emit(const LoginLoading());
      await registerUseCase.call(
        RegisterUserParams(email: email, password: password),
      );
      emit(const LoginSuccess());
    } on CosException catch (e) {
      emit(LoginFailure(failure: UiFailure.fromCosException(e)));
    } catch (_) {
      emit(const LoginFailure(failure: UiFailure(message: 'Unknown error')));
    }
  }
}
