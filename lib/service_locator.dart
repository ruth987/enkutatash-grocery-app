import 'package:enk_asses/core/network/network.dart';
import 'package:enk_asses/features/glocery/data_layer/data_source/grocery_remote.dart';
import 'package:enk_asses/features/glocery/data_layer/repo_imp/grocery_repo_imp.dart';
import 'package:enk_asses/features/glocery/domain/usecase/get_groceries_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

void init() async {
  // External dependencies
  getIt.registerSingletonAsync<SharedPreferences>(
      () => SharedPreferences.getInstance());
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => InternetConnectionChecker());

  // Core
  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfo(getIt()));

  // Data sources

  getIt.registerLazySingleton(() => GroceryRemoteDataSource(dio: getIt()));

  // Repositories
  getIt.registerLazySingleton<GroceryRepoImp>(() => GroceryRepoImp(
        groceryRemoteDataSource: getIt(),
        networkInfo: getIt(),
      ));

  // Use cases
  getIt.registerLazySingleton(
      () => GetGroceriesUsecase(getIt<GroceryRepoImp>()));
}
