import 'dart:convert';

import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';

abstract class AuthDataSource {
  Future<void> register(String email, String password);
  Future<bool> isAuthenticated();
  Future<void> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final LocalStorageAdapter localStorage;

  AuthDataSourceImpl({required this.localStorage});

  @override
  Future<void> register(String email, String password) async {
    final credentials = '$email:$password';
    final stringToBase64 = utf8.fuse(base64);
    final encoded = stringToBase64.encode(credentials);
    await localStorage.write(LocalStorageKeys.session, encoded);
  }

  @override
  Future<bool> isAuthenticated() async {
    final session = await localStorage.read(LocalStorageKeys.session);
    return session != null;
  }

  @override
  Future<void> logout() async {
    await localStorage.delete(LocalStorageKeys.session);
  }
}
