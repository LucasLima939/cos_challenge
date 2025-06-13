import 'package:cos_challenge/core/utils/use_case.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class RegisterUserUseCase implements UseCase<void, RegisterUserParams> {
  final AuthRepository repository;

  RegisterUserUseCase({required this.repository});

  @override
  Future<void> call(RegisterUserParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterUserParams extends Equatable {
  final String email;
  final String password;

  const RegisterUserParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
