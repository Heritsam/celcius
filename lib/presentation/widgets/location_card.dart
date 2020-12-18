import 'package:celcius/core/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({
    Key key,
    @required this.onTap,
    @required this.title,
  }) : super(key: key);

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: blueColor.withOpacity(.12)),
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: SvgPicture.asset('assets/ic_location.svg'),
        title: Text(title, style: textThemeBold),
      ),
    );
  }
}
