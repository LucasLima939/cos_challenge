import 'package:cos_challenge/core/utils/use_case.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';

class RegisterUserUseCase implements UseCase<void, RegisterUserParams> {
  final AuthRepository repository;

  RegisterUserUseCase({required this.repository});

  @override
  Future<void> call(RegisterUserParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterUserParams {
  final String email;
  final String password;

  RegisterUserParams({required this.email, required this.password});
}
