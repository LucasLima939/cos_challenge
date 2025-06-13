import 'package:cos_challenge/core/utils/use_case.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';

class UserLogoutUseCase implements UseCase<void, void> {
  final AuthRepository repository;

  UserLogoutUseCase({required this.repository});

  @override
  Future<void> call(void params) async {
    return await repository.logout();
  }
}
