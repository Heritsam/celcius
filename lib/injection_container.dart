import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'core/utils/dio_helper.dart';
import 'presentation/blocs/weather_bloc.dart';
import 'weather/repositories/location_repository.dart';
import 'weather/repositories/weather_repository.dart';

final sl = GetIt.instance;

Future<void> inject() async {
  //! Core
  sl.registerLazySingleton<Logger>(() => Logger());
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<DioHelper>(() => DioHelper(sl()));

  // Repositories
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl(), sl()),
  );

  // Blocs
  sl.registerFactory<WeatherBloc>(() => WeatherBloc(sl()));
}
