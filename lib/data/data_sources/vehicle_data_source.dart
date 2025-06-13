import 'dart:convert';

import 'package:cos_challenge/core/constants/http_paths.dart';
import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/domain/models/exceptions/cos_exception.dart';

abstract class VehicleDataSource {
  Future<Map<String, dynamic>> getVehicle({required String vin});
  Future<void> saveVehicleLocally({
    required String vin,
    required Map<String, dynamic> vehicle,
  });
}

class VehicleDataSourceImpl implements VehicleDataSource {
  final LocalStorageAdapter localStorage;
  final HttpAdapter http;

  VehicleDataSourceImpl({required this.localStorage, required this.http});

  @override
  Future<Map<String, dynamic>> getVehicle({required String vin}) async {
    final url = '${HttpPaths.vehicles}?vin=$vin';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    if (response.statusCode == 500) {
      final vehicles = await localStorage.read(LocalStorageKeys.vehicles);
      final vehicle = vehicles != null ? jsonDecode(vehicles)[vin] : null;
      if (vehicle != null) return vehicle;
    }

    final errorJson = jsonDecode(response.body);
    throw CosException(errorJson['message'], errorCode: response.statusCode);
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
