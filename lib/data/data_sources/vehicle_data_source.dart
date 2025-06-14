import 'dart:async';
import 'dart:convert';

import 'package:cos_challenge/core/constants/http_paths.dart';
import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/cos_client.dart';
import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:http/http.dart';

abstract class VehicleDataSource {
  Future<Map<String, dynamic>> getVehicle({required String vin});
  Future<Map<String, dynamic>> getVehicleFromLocalStorage({
    required String vin,
  });
  Future<void> saveVehicleLocally({
    required String vin,
    required Map<String, dynamic> vehicle,
  });
}

class VehicleDataSourceImpl implements VehicleDataSource {
  final LocalStorageAdapter localStorage;
  final HttpAdapter http;

  VehicleDataSourceImpl({required this.localStorage, required this.http});

  String? userSession;

  @override
  Future<Map<String, dynamic>> getVehicle({required String vin}) async {
    try {
      userSession ??= await localStorage.read(LocalStorageKeys.session);
      final headers = userSession != null
          ? {CosChallenge.user: userSession!}
          : null;

      final url = '${HttpPaths.vehicles}?vin=$vin';
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }

      final errorJson = jsonDecode(response.body);
      throw CosException(errorJson['message'], errorCode: response.statusCode);
    } on CosException {
      rethrow;
    } on ClientException {
      throw CosException('Auth', errorCode: 401);
    } on TimeoutException {
      throw CosException('Timeout', errorCode: 429);
    } catch (e) {
      throw CosException(e.toString(), errorCode: 500);
    }
  }

  @override
  Future<Map<String, dynamic>> getVehicleFromLocalStorage({
    required String vin,
  }) async {
    final vehicles = await localStorage.read(LocalStorageKeys.vehicles);
    final vehicle = vehicles != null ? jsonDecode(vehicles)[vin] : null;
    return vehicle;
  }

  @override
  Future<void> saveVehicleLocally({
    required String vin,
    required Map<String, dynamic> vehicle,
  }) async {
    final vehicles = await localStorage.read(LocalStorageKeys.vehicles);
    final newVehicles = vehicles != null ? jsonDecode(vehicles) : {};
    newVehicles[vin] = vehicle;
    await localStorage.write(
      LocalStorageKeys.vehicles,
      jsonEncode(newVehicles),
    );
  }
}
