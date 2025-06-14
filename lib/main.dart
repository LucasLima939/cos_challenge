import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/data/data_sources/auth_data_source.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';
import 'package:cos_challenge/my_app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(authRepository: await getAuthRepository()));
}

Future getAuthRepository() async {
  final localStorage = SpLocalStorageAdapterImpl(
    sharedPreferences: await SharedPreferences.getInstance(),
  );
  final dataSource = AuthDataSourceImpl(localStorage: localStorage);
  return AuthRepositoryImpl(dataSource: dataSource);
}
