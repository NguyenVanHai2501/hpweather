
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  final String value;
  final String unit;
  final String imageUrl;

  const WeatherItem({
    Key? key, required this.value, required this.unit, required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(

        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset(imageUrl),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(value + unit, //data gió
            style: Theme
                .of(context)
                .textTheme
                .caption
                ?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontFamily: 'flutterfont'
            ),
          ),
        ],
      ),
    );
  }
}