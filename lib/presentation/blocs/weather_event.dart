part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class WeatherFetched extends WeatherEvent {
  const WeatherFetched({
    this.city,
    this.latitude,
    this.longitude,
  });

  final String city;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [city];
}

class WeatherRefreshRequested extends WeatherEvent {
  const WeatherRefreshRequested(this.city);

  final String city;

  @override
  List<Object> get props => [city];
}
