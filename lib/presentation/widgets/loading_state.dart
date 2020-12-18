import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 120,
        width: 120,
        child: FlareActor(
          'assets/worldspin.flr',
          animation: 'roll',
          shouldClip: true,
        ),
      ),
    );
  }
}
