import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../util/utils.dart' as util;
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WeatherState();
  }
}


class WeatherState extends State<Weather> {

  String _cityEntered;

  Future _goToNextScreen(BuildContext context) async {
    Map results = await Navigator.of(context).push(
      new MaterialPageRoute<Map>(builder: (BuildContext context) {
        return new ChangeCity();
      })
    );

    if (results != null && results.containsKey('city')) {
      _cityEntered = results['city'];
    }
  }

  void weatherInfo() async {
      Map data = await getWeatherData(util.openWeatherKey, util.defaultCity);
      print(data.toString());
  }

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
          IconButton(
              icon: new Icon(Icons.menu),
              onPressed: () {
                return _goToNextScreen(context);
              })
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
              '${_cityEntered == null ? util.defaultCity : _cityEntered}',
              style: cityStyle(),
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            margin: EdgeInsets.fromLTRB(0.0, 200.0, 0.0, 0.0),
            child: Image.asset('images/light_rain.png'),
          ),
          // Weather Data Container
          Container(
            margin: const EdgeInsets.fromLTRB(100.0, 100.0, 0.0, 0.0),
            child: updateTemperatureWidget('$_cityEntered'),
          )
        ],
      ),
    );
  }
}

Future<Map> getWeatherData(String appId, String city) async {
  String apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${util.openWeatherKey}&units=imperial";
  http.Response response = await http.get(apiUrl);
  return json.decode(response.body);
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

TextStyle weatherMetaStyle() {
  return new TextStyle(
    color: Colors.white70,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    fontSize: 17.0
  );
}

  Widget updateTemperatureWidget(String city) {
    return new FutureBuilder(
      future: getWeatherData(util.openWeatherKey, city != null ? city :util.defaultCity),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        // get JSON data and setup widgets
        if (snapshot.hasData) {
          Map content = snapshot.data;
          if (content != null) {
            double temp = content['main']['temp'];
            return new Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    title: Text(
                      '${content['main']['temp'].toString()}°F',
                      style: TextStyle(color: Colors.white, fontSize: 50.0, fontWeight: FontWeight.w500),),
                    subtitle: ListTile(
                      title: Text(
                        'Humidty: ${content['main']['humidity'].toString()}%\n'
                            'Min: ${content['main']['temp_min'].toString()}°F\n'
                            'Max: ${content['main']['temp_max'].toString()}°F',
                        style: weatherMetaStyle(),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Text('Loading', style: TextStyle(color: Colors.white70, fontSize: 22.5),);

        }
        return Text('Loading..', style: TextStyle(color: Colors.white, fontSize: 32.3),);
      });
}

class ChangeCity extends StatelessWidget {

  var _cityFieldController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Change City'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Image.asset('images/white_snow.png',
              width: 490.0,
              height: 1200.0,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter a city...'
                  ),
                  controller: _cityFieldController,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                  color: Colors.white70,
                    textColor: Colors.redAccent,
                    onPressed: () {
                      Navigator.pop(context, {
                        'city': _cityFieldController.text
                      });
                    },
                    child: Text('Get Weather')),
              )
            ],
          )
        ],
      ),
    );
  }
}

