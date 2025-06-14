import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/domain/use_cases/get_vehicle_by_vin_use_case.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_cubit.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_state.dart';
import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/cos_mock_credentials.dart';
@GenerateMocks([GetVehicleByVinUseCase])
import 'vehicle_search_cubit_test.mocks.dart';

void main() {
  late VehicleSearchCubit vehicleSearchCubit;
  late MockGetVehicleByVinUseCase mockGetVehicleByVinUseCase;

  final vin = CosMockCredentials.vin;
  final vehicleException = CosException('Unknown error', errorCode: 500);
  final vehicle = VehicleModel.fromJson(
    jsonDecode(CosMockCredentials.vehicleJson),
  );

  setUp(() {
    mockGetVehicleByVinUseCase = MockGetVehicleByVinUseCase();
    vehicleSearchCubit = VehicleSearchCubit(
      getVehicleByVinUseCase: mockGetVehicleByVinUseCase,
    );
  });

  group('VehicleSearchCubit', () {
    test('initial state is VehicleSearchInitial', () {
      expect(vehicleSearchCubit.state, VehicleSearchInitial());
    });

    blocTest<VehicleSearchCubit, VehicleSearchState>(
      'searchVehicle should emit VehicleSearchLoading then VehicleSearchSuccess when searchVehicle has no errors',
      build: () => vehicleSearchCubit,
      act: (cubit) {
        when(
          mockGetVehicleByVinUseCase.call(vin),
        ).thenAnswer((_) async => vehicle);
        return cubit.searchVehicle(vin);
      },
      expect: () => [
        VehicleSearchLoading(),
        VehicleSearchSuccess(vehicle: vehicle),
      ],
    );
  });

  blocTest<VehicleSearchCubit, VehicleSearchState>(
    'searchVehicle should emit VehicleSearchLoading then VehicleSearchFailure when searchVehicle has errors',
    build: () => vehicleSearchCubit,
    act: (cubit) {
      when(mockGetVehicleByVinUseCase.call(vin)).thenThrow(vehicleException);
      return cubit.searchVehicle(vin);
    },
    expect: () => [
      VehicleSearchLoading(),
      VehicleSearchFailure(
        failure: UiFailure.fromCosException(vehicleException),
      ),
    ],
  );

  blocTest<VehicleSearchCubit, VehicleSearchState>(
    'searchVehicle should emit VehicleSearchLoading then VehicleSearchFailure when searchVehicle has unknown errors',
    build: () => vehicleSearchCubit,
    act: (cubit) {
      when(mockGetVehicleByVinUseCase.call(vin)).thenThrow(Exception());
      return cubit.searchVehicle(vin);
    },
    expect: () => [
      VehicleSearchLoading(),
      VehicleSearchFailure(failure: UiFailure(message: 'Unknown error')),
    ],
  );
}
