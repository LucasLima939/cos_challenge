import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  const LoginSuccess();
}

class LoginFailure extends LoginState {
  final UiFailure failure;
  const LoginFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}
