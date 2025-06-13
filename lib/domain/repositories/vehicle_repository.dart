import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';

abstract class VehicleRepository {
  Future<VehicleModel> getVehicle(String vin);
  Future<void> saveVehicleLocally(String vin, VehicleModel vehicle);
}

class VehicleRepositoryImpl implements VehicleRepository {
  final VehicleDataSource dataSource;

  VehicleRepositoryImpl({required this.dataSource});

  @override
  Future<VehicleModel> getVehicle(String vin) async {
    final vehicle = await dataSource.getVehicle(vin: vin);
    return VehicleModel.fromJson(vehicle);
  }

  @override
  Future<void> saveVehicleLocally(String vin, VehicleModel vehicle) async {
    await dataSource.saveVehicleLocally(vin: vin, vehicle: vehicle.toJson());
  }
}
