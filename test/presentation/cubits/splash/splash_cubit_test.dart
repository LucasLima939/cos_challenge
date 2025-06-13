import 'package:bloc_test/bloc_test.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_cubit.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cos_challenge/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([IsUserAuthenticatedUseCase])
import 'splash_cubit_test.mocks.dart';

void main() {
  late MockIsUserAuthenticatedUseCase mockIsUserAuthenticatedUseCase;
  late SplashCubit splashCubit;

  setUp(() {
    mockIsUserAuthenticatedUseCase = MockIsUserAuthenticatedUseCase();
    splashCubit = SplashCubit(
      isUserAuthenticatedUseCase: mockIsUserAuthenticatedUseCase,
    );
  });

  group('SplashCubit', () {
    test('initial state is SplashInitial', () {
      expect(splashCubit.state, SplashInitial());
    });
    blocTest<SplashCubit, SplashState>(
      'checkUserAuthentication should emit SplashAuthenticated when user is authenticated',
      build: () => splashCubit,
      act: (cubit) {
        when(
          mockIsUserAuthenticatedUseCase.call(null),
        ).thenAnswer((_) async => true);
        return cubit.checkUserAuthentication();
      },
      expect: () => [SplashAuthenticated()],
    );

    blocTest<SplashCubit, SplashState>(
      'checkUserAuthentication should emit SplashUnauthenticated when user is not authenticated',
      build: () => splashCubit,
      act: (cubit) {
        when(
          mockIsUserAuthenticatedUseCase.call(null),
        ).thenAnswer((_) async => false);
        return cubit.checkUserAuthentication();
      },
      expect: () => [SplashUnauthenticated()],
    );

    blocTest<SplashCubit, SplashState>(
      'checkUserAuthentication should emit SplashUnauthenticated when an error occurs',
      build: () => splashCubit,
      act: (cubit) {
        when(mockIsUserAuthenticatedUseCase.call(null)).thenThrow(Exception());
        return cubit.checkUserAuthentication();
      },
      expect: () => [SplashUnauthenticated()],
    );
  });
}
