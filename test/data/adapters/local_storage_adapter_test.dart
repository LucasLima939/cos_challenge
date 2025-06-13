import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

@GenerateMocks([SharedPreferences])
import 'local_storage_adapter_test.mocks.dart';

void main() {
  late MockSharedPreferences sharedPreferences;
  late SpLocalStorageAdapterImpl localStorageAdapter;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    localStorageAdapter = SpLocalStorageAdapterImpl(
      sharedPreferences: sharedPreferences,
    );
  });

  test('should call the shared preferences to write the value', () async {
    when(sharedPreferences.setString(any, any)).thenAnswer((_) async => true);
    await localStorageAdapter.write('key', 'value');
    verify(sharedPreferences.setString('key', 'value')).called(1);
  });

  test('should call the shared preferences to read the value', () async {
    const expected = 'value';
    when(sharedPreferences.getString(any)).thenReturn(expected);
    final value = await localStorageAdapter.read('key');
    expect(value, 'value');
  });

  test('should call the shared preferences to delete the value', () async {
    when(sharedPreferences.remove(any)).thenAnswer((_) async => true);
    await localStorageAdapter.delete('key');
    verify(sharedPreferences.remove('key')).called(1);
  });
}
