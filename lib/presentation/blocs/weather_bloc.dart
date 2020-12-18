import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:celcius/weather/entities/weather.dart';
import 'package:equatable/equatable.dart';

import '../../weather/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this.repository) : super(WeatherLoadInProgress());

  final WeatherRepository repository;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is WeatherFetched) {
      yield WeatherLoadInProgress();

      try {
        final WeatherResponse weather = event.city != null
            ? await repository.fetchWeather(event.city)
            : await repository.fetchWeatherByLatLng(
                event.latitude,
                event.longitude,
              );

        yield WeatherLoadSuccess(weather);
      } catch (e) {
        yield WeatherLoadFailure(e.message);
      }
    }
  }
}
