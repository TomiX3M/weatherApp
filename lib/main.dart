
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String apiKey = '05860c8ae8ac87d58ed6ea8e1e0230b2';
  String link = 'https://api.openweathermap.org/data/2.5/weather?q=lagos&units=imperial&appid=05860c8ae8ac87d58ed6ea8e1e0230b2';
  var windSpeed;
  var description;
  var humidity;
  var temp;
  var currently;
  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(link));
    if(response.statusCode == HttpStatus.ok){
      final result = jsonDecode(response.body);
      setState(() {
        currently = result['weather'][0]['main'];
        description = result['weather'][0]['description'];
        temp = result['main']['temp'];
        humidity = result['main']['humidity'];
        windSpeed = result['wind']['speed'];
      });
    }
    else{
      return null;
    }
  }

  void initState(){
    getWeather();
    super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text('Currently in Lagos',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
                Text(
                    (temp!=null)? temp.toString()+"\u00B0":'Loading',
                    style: TextStyle(
                        fontSize: 80,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    (currently!=null)?currently.toString():'Loading',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: ListView(
               children: <Widget>[
                 ListTile(
                   leading:Padding(
                     padding: const EdgeInsets.only(left:7.0),
                     child: FaIcon(FontAwesomeIcons.thermometerHalf),
                   ),
                   title: Text('Temperature'),
                   trailing:Text((temp!=null)?temp.toString() + "\u00B0":'Loading')
                 ),
                 ListTile(
                     leading: FaIcon(FontAwesomeIcons.cloud),
                     title: Text('Weather'),
                     trailing:Text((description!=null)?description.toString() :'Loading')
                 ),
                 ListTile(
                     leading: FaIcon(FontAwesomeIcons.sun),
                     title: Text('Humidity'),
                     trailing:Text((humidity!=null)?humidity.toString():'Loading')
                 ),
                 ListTile(
                     leading: FaIcon(FontAwesomeIcons.wind),
                     title: Text('Wind'),
                     trailing:Text((windSpeed!=null)?windSpeed.toString() :'Loading')
                 ),
               ],
             ),
           ),
          )
        ],
      ),
    );
  }
}
