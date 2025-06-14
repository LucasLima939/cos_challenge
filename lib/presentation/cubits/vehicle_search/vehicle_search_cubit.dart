import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:cos_challenge/domain/models/multiselection_vehicle_model.dart';
import 'package:cos_challenge/domain/use_cases/get_vehicle_by_vin_use_case.dart';
import 'package:cos_challenge/domain/use_cases/save_vehicle_locally_use_case.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_state.dart';
import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleSearchCubit extends Cubit<VehicleSearchState> {
  final GetVehicleByVinUseCase getVehicleByVinUseCase;
  final SaveVehicleLocallyUseCase saveVehicleUseCase;

  VehicleSearchCubit({
    required this.getVehicleByVinUseCase,
    required this.saveVehicleUseCase,
  }) : super(const VehicleSearchInitial());

  Future<void> searchVehicle(String vin) async {
    try {
      emit(const VehicleSearchLoading());
      final vehicle = await getVehicleByVinUseCase.call(vin);
      await saveVehicleUseCase(
        SaveVehicleLocallyParams(vehicle: vehicle, vin: vin),
      );
      emit(VehicleSearchSuccess(vehicle: vehicle));
    } on CosException catch (e) {
      if (e.errorCode == 300) {
        emitMultiSelectionVehicles(e.multiSelectionVehicles ?? []);
      } else {
        emit(VehicleSearchFailure(failure: UiFailure.fromCosException(e)));
      }
    } catch (e) {
      emit(
        const VehicleSearchFailure(
          failure: UiFailure(message: 'Unknown error'),
        ),
      );
    }
  }

  void emitMultiSelectionVehicles(
    List<Map<String, dynamic>> multiSelectionVehicles,
  ) {
    final vehicles = multiSelectionVehicles
        .map((vehicle) => MultiSelectionVehicleModel.fromJson(vehicle))
        .toList();
    vehicles.sort((a, b) => b.similarity.compareTo(a.similarity));
    emit(VehicleSearchMultiSelection(vehicles: vehicles));
  }
}
