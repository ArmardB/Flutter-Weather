import 'package:flutter/material.dart';

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WeatherState();
  }

}


class WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Flutter Weather',

        ),
        actions: <Widget>[

        ],
      ),
    );
  }

}