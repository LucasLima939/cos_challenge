import 'package:equatable/equatable.dart';

class CosException extends Equatable implements Exception {
  final String message;
  final int? errorCode;
  final List<Map<String, dynamic>>? multiSelectionVehicles;

  const CosException(this.message, {this.errorCode})
    : multiSelectionVehicles = null;

  const CosException.fromMultiSelection({required this.multiSelectionVehicles})
    : message = '',
      errorCode = 300;

  @override
  List<Object?> get props => [message, errorCode, multiSelectionVehicles];
}
