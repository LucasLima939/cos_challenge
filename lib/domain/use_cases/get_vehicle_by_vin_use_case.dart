import 'package:cos_challenge/domain/repositories/vehicle_repository.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/core/utils/use_case.dart';

class GetVehicleByVinUseCase implements UseCase<VehicleModel, String> {
  final VehicleRepository repository;

  GetVehicleByVinUseCase({required this.repository});

  @override
  Future<VehicleModel> call(String vin) async {
    return repository.getVehicle(vin);
  }
}
