import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
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
    try {
      final vehicle = await dataSource.getVehicle(vin: vin);
      return VehicleModel.fromJson(vehicle);
    } on CosException catch (e) {
      if (e.errorCode != null && e.errorCode! > 399) {
        final vehicle = await dataSource.getVehicleFromLocalStorage(vin: vin);
        return vehicle != null ? VehicleModel.fromJson(vehicle) : throw e;
      }
      rethrow;
    }
  }

  @override
  Future<void> saveVehicleLocally(String vin, VehicleModel vehicle) async {
    await dataSource.saveVehicleLocally(vin: vin, vehicle: vehicle.toJson());
  }
}
