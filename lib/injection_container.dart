import 'package:cos_challenge/cos_client.dart';
import 'package:cos_challenge/data/adapters/http_adapter.dart';
import 'package:cos_challenge/data/adapters/local_storage_adapter.dart';
import 'package:cos_challenge/data/data_sources/auth_data_source.dart';
import 'package:cos_challenge/data/data_sources/vehicle_data_source.dart';
import 'package:cos_challenge/domain/repositories/auth_repository.dart';
import 'package:cos_challenge/domain/repositories/vehicle_repository.dart';
import 'package:cos_challenge/domain/use_cases/get_vehicle_by_vin_use_case.dart';
import 'package:cos_challenge/domain/use_cases/is_user_authenticated_use_case.dart';
import 'package:cos_challenge/domain/use_cases/register_user_use_case.dart';
import 'package:cos_challenge/presentation/cubits/login/login_cubit.dart';
import 'package:cos_challenge/presentation/cubits/splash/splash_cubit.dart';
import 'package:cos_challenge/presentation/cubits/vehicle_search/vehicle_search_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initContainer() async {
  // Shared Preferences
  final sharedPreferences = await SharedPreferences.getInstance();

  // Adapters
  getIt.registerSingleton<LocalStorageAdapter>(
    SpLocalStorageAdapterImpl(sharedPreferences: sharedPreferences),
  );
  getIt.registerSingleton<HttpAdapter>(
    HttpAdapterImpl(httpClient: CosChallenge.httpClient),
  );

  // Data Sources
  getIt.registerSingleton<AuthDataSource>(
    AuthDataSourceImpl(localStorage: getIt<LocalStorageAdapter>()),
  );
  getIt.registerSingleton<VehicleDataSource>(
    VehicleDataSourceImpl(
      localStorage: getIt<LocalStorageAdapter>(),
      http: getIt<HttpAdapter>(),
    ),
  );

  // Repositories
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(dataSource: getIt<AuthDataSource>()),
  );
  getIt.registerSingleton<VehicleRepository>(
    VehicleRepositoryImpl(dataSource: getIt<VehicleDataSource>()),
  );

  // Use Cases
  getIt.registerSingleton<IsUserAuthenticatedUseCase>(
    IsUserAuthenticatedUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<RegisterUserUseCase>(
    RegisterUserUseCase(repository: getIt<AuthRepository>()),
  );
  getIt.registerSingleton<GetVehicleByVinUseCase>(
    GetVehicleByVinUseCase(repository: getIt<VehicleRepository>()),
  );
  // Cubits
  getIt.registerSingleton<SplashCubit>(
    SplashCubit(
      isUserAuthenticatedUseCase: getIt<IsUserAuthenticatedUseCase>(),
    ),
  );
  getIt.registerSingleton<LoginCubit>(
    LoginCubit(registerUseCase: getIt<RegisterUserUseCase>()),
  );
  getIt.registerSingleton<VehicleSearchCubit>(
    VehicleSearchCubit(getVehicleByVinUseCase: getIt<GetVehicleByVinUseCase>()),
  );
}
