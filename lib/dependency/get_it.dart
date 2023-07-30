import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:midlr/api_service/service.dart';
import 'package:midlr/database/database.dart';
import 'package:midlr/ui/auth/auth_cubit.dart';
import 'package:midlr/ui/auth/auth_service.dart';

import 'app_config/app_config.dart';
import 'navigation/navigation_service.dart';

final getItInstance = GetIt.I;

Future initDependencies(AppConfig appConfig) async {
  var securedStorage = const FlutterSecureStorage();

  // Network
  final dio = Dio();
  getItInstance.registerLazySingleton<Dio>(() => dio);

  // Storage
  getItInstance.registerSingleton<FlutterSecureStorage>(securedStorage);

  //Build configurations
  getItInstance.registerSingleton<AppConfig>(appConfig);

  // Services
  getItInstance.registerLazySingleton<NavigationServiceImpl>(
      () => NavigationServiceImpl());
  
  getItInstance.registerLazySingleton<TempDatabaseImpl>(
      () => TempDatabaseImpl(securedStorage: getItInstance()));

  getItInstance.registerLazySingleton<ServiceHelpersImp>(() =>
      ServiceHelpersImp(
          dio: getItInstance(), tempDatabaseImpl: getItInstance()));

  getItInstance.registerLazySingleton<AuthServiceImp>(() => AuthServiceImp(
      serviceHelpersImp: getItInstance(), tempDatabaseImpl: getItInstance()));

  // Cubits
  getItInstance
      .registerFactory(() => AuthCubit(authServiceImp: getItInstance()));
}
