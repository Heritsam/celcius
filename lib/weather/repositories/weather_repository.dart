import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../core/errors/exceptions.dart';
import '../../core/utils/api_client.dart';
import '../../core/utils/api_key.dart';
import '../../core/utils/dio_helper.dart';
import '../entities/weather.dart';

abstract class WeatherRepository {
  Future<WeatherResponse> fetchWeather(String city);
  Future<WeatherResponse> fetchWeatherByLatLng(double lat, double lng);
}

class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl(this.log, this.dio);

  final Logger log;
  final DioHelper dio;

  @override
  Future<WeatherResponse> fetchWeather(String city) async {
    try {
      final Response response = await dio.get(
        ApiClient.baseUrl +
            '/weather?q=$city&appid=${ApiKey.appId}&units=metric',
      );

      return WeatherResponse.fromJson(response.data);
    } on ServerException catch (e) {
      log.e(e.toString());
      rethrow;
    } catch (e) {
      log.wtf(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<WeatherResponse> fetchWeatherByLatLng(double lat, double lng) async {
    try {
      final Response response = await dio.get(
        ApiClient.baseUrl +
            '/weather?lat=$lat&lon=$lng&appid=${ApiKey.appId}&units=metric',
      );

      return WeatherResponse.fromJson(response.data);
    } on ServerException catch (e) {
      log.e(e.toString());
      rethrow;
    } catch (e) {
      log.wtf('$lat, $lng');
      log.wtf(e.toString());
      throw ServerException(e.toString());
    }
  }
}
