import 'dart:convert';

import 'package:cos_challenge/core/constants/http_paths.dart';
import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../core/cos_mock_credentials.dart';
@GenerateMocks([LocalStorageAdapter, HttpAdapter])
import 'vehicles_data_source_test.mocks.dart';

void main() {
  late MockLocalStorageAdapter localStorage;
  late MockHttpAdapter http;
  late VehicleDataSource vehicleDataSource;

  const vin = CosMockCredentials.vin;
  final url = '${HttpPaths.vehicles}?vin=$vin';
  final errorMessage = CosMockCredentials.errorMessage;
  final errorJson = CosMockCredentials.errorJson;
  final vehicleJson = CosMockCredentials.vehicleJson;
  final localStorageVehicles = jsonEncode({vin: jsonDecode(vehicleJson)});

  setUp(() {
    localStorage = MockLocalStorageAdapter();
    http = MockHttpAdapter();
    vehicleDataSource = VehicleDataSourceImpl(
      localStorage: localStorage,
      http: http,
    );
  });

  group('getVehicle', () {
    test(
      'When the getVehicle method is called, it should call the correct route and return the vehicle',
      () async {
        when(http.get(url)).thenAnswer((_) async => Response(vehicleJson, 200));
        final vehicle = await vehicleDataSource.getVehicle(vin: vin);
        expect(vehicle, jsonDecode(vehicleJson));
      },
    );

    test(
      'When the getVehicle method is called with an invalid vin, it should throw an exception',
      () async {
        when(http.get(url)).thenAnswer((_) async => Response(errorJson, 400));
        expect(
          vehicleDataSource.getVehicle(vin: vin),
          throwsA(CosException(errorMessage, errorCode: 400)),
        );
      },
    );

    test(
      'When the server has some error but the vehicle exists locally, it should return the vehicle',
      () async {
        when(http.get(url)).thenAnswer((_) async => Response(errorJson, 500));
        when(
          localStorage.read(LocalStorageKeys.vehicles),
        ).thenAnswer((_) async => localStorageVehicles);
        final vehicle = await vehicleDataSource.getVehicle(vin: vin);
        expect(vehicle, jsonDecode(vehicleJson));
      },
    );
  });

  group('saveVehicleLocally', () {
    test(
      'When the saveVehicleLocally method is called, it should save the vehicle locally',
      () async {
        when(
          localStorage.write(LocalStorageKeys.vehicles, vehicleJson),
        ).thenAnswer((_) async => Response(vehicleJson, 200));
        when(
          localStorage.read(LocalStorageKeys.vehicles),
        ).thenAnswer((_) async => localStorageVehicles);
        await vehicleDataSource.saveVehicleLocally(
          vin: vin,
          vehicle: jsonDecode(vehicleJson),
        );
        verify(
          localStorage.write(LocalStorageKeys.vehicles, localStorageVehicles),
        ).called(1);
      },
    );
  });
}
