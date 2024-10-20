import 'package:flutter_shortest_path/application/execution/execution_process_bloc.dart';
import 'package:flutter_shortest_path/domain/core/storage/local_storage.dart';
import 'package:flutter_shortest_path/infrastructure/core/api/dio_config.dart';
import 'package:flutter_shortest_path/infrastructure/execution/execution_facade.dart';
import 'package:flutter_shortest_path/infrastructure/start/url_facade.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void configureInjection() {
  registerBlocs();

  getIt.registerLazySingleton<ILocalStorage>(() => SecurePrefsStorage());
  getIt.registerLazySingleton<IUrlFacade>(() => UrlFacade());
  getIt.registerLazySingleton<IExecutionFacade>(() => ExecutionFacade());
}

void registerBlocs() {
  getIt.registerFactory(() => DioConfig());

  getIt.registerFactory(() => ExecutionProcessBloc());
}
