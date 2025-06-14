import 'package:cos_challenge/domain/models/multiselection_vehicle_model.dart';
import 'package:cos_challenge/domain/models/vehicle_model.dart';
import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:equatable/equatable.dart';

abstract class VehicleSearchState extends Equatable {
  const VehicleSearchState();

  @override
  List<Object?> get props => [];
}

class VehicleSearchInitial extends VehicleSearchState {
  const VehicleSearchInitial();
}

class VehicleSearchLoading extends VehicleSearchState {
  const VehicleSearchLoading();
}

class VehicleSearchSuccess extends VehicleSearchState {
  final VehicleModel vehicle;
  const VehicleSearchSuccess({required this.vehicle});
}

class VehicleSearchMultiSelection extends VehicleSearchState {
  final List<MultiSelectionVehicleModel> vehicles;
  const VehicleSearchMultiSelection({required this.vehicles});
}

class VehicleSearchFailure extends VehicleSearchState {
  final UiFailure failure;
  const VehicleSearchFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
