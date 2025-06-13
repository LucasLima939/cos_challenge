import 'package:equatable/equatable.dart';

class CosException extends Equatable implements Exception {
  final String message;
  final int? errorCode;

  const CosException(this.message, {this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}
