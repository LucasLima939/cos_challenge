import 'dart:convert';
import 'dart:math';

import 'package:cos_challenge/core/constants/http_paths.dart';
import 'package:cos_challenge/core/constants/local_storage_keys.dart';
import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/models/exceptions/cos_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([LocalStorageAdapter, HttpAdapter])
import 'vehicles_data_source_test.mocks.dart';

void main() {
  late MockLocalStorageAdapter localStorage;
  late MockHttpAdapter http;
  late VehicleDataSource vehicleDataSource;

  const vin = '1YVWB32R5CU123456';
  final url = '${HttpPaths.vehicles}?vin=$vin';
  final errorMessage = 'Please try again in 111 seconds';

  final errorJson =
      '''
  {
  "msgKey": "maintenance",
  "params": { "delaySeconds": "111" },
  "message": "$errorMessage"
  }
  ''';

  final vehicleJson =
      '''
    {
      "id": ${Random().nextInt(1000000)},
      "feedback": "Please modify the price.",
      "valuatedAt": "2023-01-05T14:08:40.456Z",
      "requestedAt": "2023-01-05T14:08:40.456Z",
      "createdAt": "2023-01-05T14:08:40.456Z",
      "updatedAt": "2023-01-05T14:08:42.153Z",
      "make": "Toyota",
      "model": "GT 86 Basis",
      "externalId": "DE003-018601450020008",
      "_fk_sellerUser": "25475e37-6973-483b-9b15-cfee721fc29f",
      "price": ${Random().nextInt(1000)},
      "positiveCustomerFeedback": ${Random().nextBool()},
      "_fk_uuid_auction": "3e255ad2-36d4-4048-a962-5e84e27bfa6e",
      "inspectorRequestedAt": "2023-01-05T14:08:40.456Z",
      "origin": "AUCTION",
      "estimationRequestId": "3a295387d07f"
    }
''';

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
