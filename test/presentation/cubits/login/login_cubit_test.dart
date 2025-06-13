import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/domain/exceptions/cos_exception.dart';
import 'package:cos_challenge/domain/use_cases/register_user_use_case.dart';
import 'package:cos_challenge/presentation/cubits/login/login_cubit.dart';
import 'package:cos_challenge/presentation/cubits/login/login_state.dart';
import 'package:cos_challenge/presentation/failure/ui_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../core/cos_mock_credentials.dart';
@GenerateMocks([RegisterUserUseCase])
import 'login_cubit_test.mocks.dart';

void main() {
  late MockRegisterUserUseCase mockRegisterUserUseCase;
  late LoginCubit loginCubit;

  final loginParams = RegisterUserParams(
    email: CosMockCredentials.email,
    password: CosMockCredentials.password,
  );
  final loginException = CosException('Invalid credentials', errorCode: 401);

  setUp(() {
    mockRegisterUserUseCase = MockRegisterUserUseCase();
    loginCubit = LoginCubit(registerUseCase: mockRegisterUserUseCase);
  });

  group('LoginCubit', () {
    test('initial state is LoginInitial', () {
      expect(loginCubit.state, LoginInitial());
    });
  });

  blocTest<LoginCubit, LoginState>(
    'login should emit LoginLoading then LoginSuccess when login has no errors',
    build: () => loginCubit,
    act: (cubit) {
      when(mockRegisterUserUseCase.call(loginParams)).thenAnswer((_) async {});
      return cubit.login(loginParams.email, loginParams.password);
    },
    expect: () => [LoginLoading(), LoginSuccess()],
  );

  blocTest<LoginCubit, LoginState>(
    'login should emit LoginLoading then LoginFailure when login has errors',
    build: () => loginCubit,
    act: (cubit) {
      when(mockRegisterUserUseCase.call(loginParams)).thenThrow(loginException);
      return cubit.login(loginParams.email, loginParams.password);
    },
    expect: () => [
      LoginLoading(),
      LoginFailure(failure: UiFailure.fromCosException(loginException)),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'login should emit LoginLoading then LoginFailure when login has unknown errors',
    build: () => loginCubit,
    act: (cubit) {
      when(mockRegisterUserUseCase.call(loginParams)).thenThrow(Exception());
      return cubit.login(loginParams.email, loginParams.password);
    },
    expect: () => [
      LoginLoading(),
      LoginFailure(failure: UiFailure(message: 'Unknown error')),
    ],
  );
}
