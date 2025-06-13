import 'package:cos_challenge/core/utils/use_case.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';

class IsUserAuthenticatedUseCase implements UseCase<bool, void> {
  final AuthRepository repository;

  IsUserAuthenticatedUseCase({required this.repository});

  @override
  Future<bool> call(void params) async {
    return await repository.isAuthenticated();
  }
}
