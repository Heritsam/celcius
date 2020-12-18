import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location(this.city);

  final String city;

  @override
  List<Object> get props => [city];
}
