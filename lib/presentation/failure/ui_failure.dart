import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:equatable/equatable.dart';

class UiFailure extends Equatable {
  final String message;

  const UiFailure({required this.message});

  factory UiFailure.fromCosException(CosException exception) {
    switch (exception.errorCode?.toString()) {
      case '401':
        return const UiFailure(message: 'Invalid credentials');
      case '404':
        return const UiFailure(
          message: 'This vehicle does not exist, use another vin number',
        );
      case '409':
        return const UiFailure(message: 'This vehicle is already registered');
      case '429':
        return const UiFailure(
          message: 'Too many requests, please try again later',
        );
      case '500':
        return const UiFailure(
          message: 'Internal server error, please try again later',
        );
      case '503':
        return const UiFailure(
          message: 'Service unavailable, please try again later',
        );
      default:
        return const UiFailure(message: 'Unknown error');
    }
  }

  @override
  List<Object?> get props => [message];
}
