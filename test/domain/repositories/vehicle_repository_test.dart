import 'dart:convert';

import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/domain/repositories/vehicle_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../core/cos_mock_credentials.dart';
@GenerateMocks([VehicleDataSource])
import 'vehicle_repository_test.mocks.dart';

void main() {
  late MockVehicleDataSource vehicleDataSource;
  late VehicleRepository vehicleRepository;

  final vehicleJson = CosMockCredentials.vehicleJson;
  final vehicleModel = VehicleModel.fromJson(jsonDecode(vehicleJson));

  setUp(() {
    vehicleDataSource = MockVehicleDataSource();
    vehicleRepository = VehicleRepositoryImpl(dataSource: vehicleDataSource);
  });

  group('getVehicle', () {
    test(
      'When the getVehicle method is called, it should call the correct method',
      () async {
        when(
          vehicleDataSource.getVehicle(vin: CosMockCredentials.vin),
        ).thenAnswer((_) async => jsonDecode(vehicleJson));
        final vehicle = await vehicleRepository.getVehicle(
          CosMockCredentials.vin,
        );
        expect(vehicle, vehicleModel);
      },
    );

    test(
      'When the getVehicle method is called with an invalid vin, it should throw an exception',
      () async {
        when(
          vehicleDataSource.getVehicle(vin: CosMockCredentials.vin),
        ).thenThrow(
          CosException(CosMockCredentials.errorMessage, errorCode: 400),
        );
        expect(
          vehicleRepository.getVehicle(CosMockCredentials.vin),
          throwsA(
            CosException(CosMockCredentials.errorMessage, errorCode: 400),
          ),
        );
      },
    );
  });

  group('saveVehicleLocally', () {
    test(
      'When the saveVehicleLocally method is called, it should call the correct method',
      () async {
        when(
          vehicleDataSource.saveVehicleLocally(
            vin: CosMockCredentials.vin,
            vehicle: vehicleModel.toJson(),
          ),
        ).thenAnswer((_) async {});
        await vehicleRepository.saveVehicleLocally(
          CosMockCredentials.vin,
          vehicleModel,
        );
        verify(
          vehicleDataSource.saveVehicleLocally(
            vin: CosMockCredentials.vin,
            vehicle: vehicleModel.toJson(),
          ),
        ).called(1);
      },
    );
  });
}
