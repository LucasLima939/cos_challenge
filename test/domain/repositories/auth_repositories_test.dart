import 'package:cos_challenge/data/data_sources/auth_data_source.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AuthDataSource])
import 'auth_repositories_test.mocks.dart';

void main() {
  late MockAuthDataSource authDataSource;
  late AuthRepository authRepository;

  const email = 'test@test.com';
  const password = '123456';

  setUp(() {
    authDataSource = MockAuthDataSource();
    authRepository = AuthRepositoryImpl(dataSource: authDataSource);
  });

  test(
    'When the register method is called, it should call the correct method',
    () async {
      when(authDataSource.register(email, password)).thenAnswer((_) async {});
      await authRepository.register(email, password);
      verify(authDataSource.register(email, password)).called(1);
    },
  );

  test(
    'When the isAuthenticated method is called, it should call the correct method',
    () async {
      when(authDataSource.isAuthenticated()).thenAnswer((_) async => true);
      final isAuthenticated = await authRepository.isAuthenticated();
      expect(isAuthenticated, true);
    },
  );

  test(
    'When the logout method is called, it should call the correct method',
    () async {
      when(authDataSource.logout()).thenAnswer((_) async {});
      await authRepository.logout();
      verify(authDataSource.logout()).called(1);
    },
  );
}
