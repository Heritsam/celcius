part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

class WeatherLoadInProgress extends WeatherState {}

class WeatherLoadSuccess extends WeatherState {
  const WeatherLoadSuccess(this.weather);

  final WeatherResponse weather;

  @override
  List<Object> get props => [weather];
}

class WeatherLoadFailure extends WeatherState {
  const WeatherLoadFailure(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
