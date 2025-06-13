import 'package:cos_challenge/core/utils/use_case.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/domain/repositories/vehicle_repository.dart';
import 'package:equatable/equatable.dart';

class SaveVehicleLocallyUseCase
    implements UseCase<void, SaveVehicleLocallyParams> {
  final VehicleRepository repository;

  SaveVehicleLocallyUseCase({required this.repository});

  @override
  Future<void> call(SaveVehicleLocallyParams params) async {
    return await repository.saveVehicleLocally(params.vin, params.vehicle);
  }
}

class SaveVehicleLocallyParams extends Equatable {
  final String vin;
  final VehicleModel vehicle;

  const SaveVehicleLocallyParams({required this.vin, required this.vehicle});

  @override
  List<Object?> get props => [vin, vehicle];
}
