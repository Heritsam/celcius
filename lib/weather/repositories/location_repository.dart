import 'package:logger/logger.dart';

import '../entities/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocations();
}

class LocationRepositoryImpl implements LocationRepository {
  const LocationRepositoryImpl(this.log);

  final Logger log;
  
  @override
  Future<List<Location>> getLocations() async {
    final List<Location> locations = [
      Location('Sydney'),
      Location('Tokyo'),
      Location('Jakarta'),
      Location('London'),
      Location('Los Angeles'),
    ];

    return locations;
  }
}
