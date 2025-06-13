import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/data/data_sources/auth_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalStorageAdapter])
import 'auth_data_source_test.mocks.dart';

void main() {
  late AuthDataSource authDataSource;
  late MockLocalStorageAdapter localStorage;

  setUp(() {
    localStorage = MockLocalStorageAdapter();
    authDataSource = AuthDataSourceImpl(localStorage: localStorage);
  });

  test(
    'When the register method is called, it should call the localStorage to write the value',
    () async {
      when(localStorage.write(any, any)).thenAnswer((_) async => true);
      await authDataSource.register('email', 'password');
      verify(localStorage.write(LocalStorageKeys.session, any)).called(1);
    },
  );

  test(
    'When the isAuthenticated method is called, it should call the localStorage to read if the value is not null',
    () async {
      when(
        localStorage.read(LocalStorageKeys.session),
      ).thenAnswer((_) async => 'value');
      final result = await authDataSource.isAuthenticated();
      expect(result, true);
    },
  );

  test(
    'When the logout method is called, it should call the localStorage to delete the value',
    () async {
      when(
        localStorage.delete(LocalStorageKeys.session),
      ).thenAnswer((_) async => true);
      await authDataSource.logout();
      verify(localStorage.delete(LocalStorageKeys.session)).called(1);
    },
  );
}
