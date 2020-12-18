import 'package:celcius/core/themes/themes.dart';
import 'package:flutter/material.dart';

enum StatusCardColor { green, pink, blue }

class StatusCard extends StatelessWidget {
  const StatusCard({
    Key key,
    @required this.color,
    @required this.title,
    @required this.subtitle,
  }) : super(key: key);

  final StatusCardColor color;
  final String title;
  final String subtitle;

  Color _generateColor(StatusCardColor color) {
    switch (color) {
      case StatusCardColor.blue:
        return blueColor;
      case StatusCardColor.pink:
        return pinkColor;
      default:
        return greenColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final myColor = _generateColor(color);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    myColor.withOpacity(.24),
                    myColor.withOpacity(0),
                  ],
                ),
              ),
            ),
            Text(
              title,
              style: textThemeBold.copyWith(
                fontSize: 16,
                color: myColor == greenColor
                    ? greenDarkColor.withOpacity(.72)
                    : myColor.withOpacity(.72),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(subtitle, style: textThemeBold.copyWith(fontSize: 14)),
      ],
    );
  }
}
