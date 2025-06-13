import 'package:cos_challenge/data/data_sources/auth_data_source.dart';

abstract class AuthRepository {
  Future<void> register(String email, String password);
  Future<bool> isAuthenticated();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<void> register(String email, String password) async {
    await dataSource.register(email, password);
  }

  @override
  Future<bool> isAuthenticated() async {
    return await dataSource.isAuthenticated();
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }
}
