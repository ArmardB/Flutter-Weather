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
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Flutter Weather',
          style: TextStyle(
            color: Colors.white
          ),
        ),
        actions: <Widget>[
          IconButton(icon: new Icon(Icons.menu), onPressed: () => debugPrint('Hello'))
        ],
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('images/umbrella.png',
            width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            )
          ),
          Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0.0),
            child: Text(
              'Medellín',
              style: cityStyle(),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('images/light_rain.png'),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30.0, 400.0, 0.0, 0.0),
            child: Text('89.9F', style: weatherIconStyle(),),
          )
        ],
      ),
    );
  }

}

TextStyle cityStyle() {
  return new TextStyle(
    color: Colors.white,
    fontSize: 22.9,
    fontStyle: FontStyle.italic
  );
}

TextStyle weatherIconStyle() {
  return new TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    fontSize: 49.9
  );
}