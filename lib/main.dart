import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/themes.dart';
import 'injection_container.dart' as di;
import 'injection_container.dart';
import 'presentation/blocs/weather_bloc.dart';
import 'presentation/views/home_page.dart';

void main() async {
  await di.inject();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Celcius',
      theme: ThemeData(
        primaryColor: blueColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.copyWith(),
      ),
      home: BlocProvider(
        create: (context) => sl<WeatherBloc>(),
        child: HomePage(),
      ),
    );
  }
}
