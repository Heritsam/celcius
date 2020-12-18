import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

import '../../core/themes/themes.dart';
import '../../injection_container.dart';
import '../../weather/entities/location.dart';
import '../../weather/repositories/location_repository.dart';
import '../blocs/weather_bloc.dart';
import '../widgets/loading_state.dart';
import '../widgets/location_card.dart';
import '../widgets/status_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WeatherBloc bloc;
  Position position;

  bool isDay = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<WeatherBloc>(context);
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final curPos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

    setState(() {
      position = curPos;
    });

    bloc.add(WeatherFetched(
      latitude: position.latitude,
      longitude: position.longitude,
    ));
  }

  String _generateWeatherIcons(String weather) {
    switch (weather) {
      case 'Clouds':
        return 'assets/weather_cloudy.png';
      case 'Fog':
        return 'assets/weather_cloudy.png';
      case 'Mist':
        return 'assets/weather_cloudy.png';
      case 'Rain':
        return 'assets/weather_raining.png';
      case 'Haze':
        return 'assets/weather_haze.png';
      default:
        return 'assets/weather_sunny.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        brightness: Brightness.light,
        leading: IconButton(
          tooltip: 'Menu',
          icon: Icon(Icons.sort, color: textColor),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (bsContext) => Material(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 2,
                          width: 64,
                          decoration: BoxDecoration(
                            color: textLightColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('Available Locations', style: textThemeBold),
                      SizedBox(height: 16),
                      FutureBuilder(
                        future: sl<LocationRepository>().getLocations(),
                        builder: (BuildContext _,
                            AsyncSnapshot<List<Location>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final items = snapshot.data;

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: items.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 16),
                                    child: LocationCard(
                                      onTap: () {
                                        Navigator.pop(context);
                                        bloc.add(WeatherFetched(
                                          latitude: position.latitude,
                                          longitude: position.longitude,
                                        ));
                                      },
                                      title: 'Current Location',
                                    ),
                                  );
                                }

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 16),
                                  child: LocationCard(
                                    onTap: () {
                                      Navigator.pop(bsContext);
                                      bloc.add(WeatherFetched(
                                        city: items[index - 1].city,
                                      ));
                                    },
                                    title: items[index - 1].city,
                                  ),
                                );
                              },
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoadSuccess) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    state.weather.sys.country,
                    style: textThemeBold.copyWith(fontSize: 16),
                  ),
                  Text(
                    state.weather.name,
                    style: textThemeBold.copyWith(fontSize: 36),
                  ),
                  SizedBox(height: 8),
                  Text(
                    DateFormat('E, d MMMM yyyy').format(DateTime.now()),
                    style: textThemeBold.copyWith(color: textLightColor),
                  ),
                  SizedBox(height: 48),
                  Center(
                    child: Text(
                      'Today',
                      style: textThemeBold.copyWith(fontSize: 24),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              _generateWeatherIcons(
                                state.weather.weather[0].main,
                              ),
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.weather.main.temp.floor().toString(),
                                style: textThemeBold.copyWith(fontSize: 48),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  '°C',
                                  style: textThemeBold.copyWith(
                                    fontSize: 24,
                                    color: textLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Text(
                                state.weather.weather[0].main,
                                style: textThemeBold.copyWith(
                                  fontSize: 24,
                                  color: textLightColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Feels like ${state.weather.main.feelsLike.floor()}°C',
                      style: textThemeBold.copyWith(color: textLightColor),
                    ),
                  ),
                  SizedBox(height: 64),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatusCard(
                        color: StatusCardColor.green,
                        title: 'Wind',
                        subtitle: state.weather.wind.speed.toString() + ' km/h',
                      ),
                      StatusCard(
                        color: StatusCardColor.blue,
                        title: 'Humidity',
                        subtitle: state.weather.main.humidity.toString() + '%',
                      ),
                      StatusCard(
                        color: StatusCardColor.pink,
                        title: 'Pressure',
                        subtitle:
                            state.weather.main.pressure.toString() + ' N/m²',
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                ],
              ),
            );
          }

          return LoadingState();
        },
      ),
    );
  }
}
