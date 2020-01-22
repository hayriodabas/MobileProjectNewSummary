import 'package:flutter/material.dart';
import 'ui/view/home/App.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Map<int, Color> color =
  {
  50:Color.fromRGBO(116,136,168, .1),
  100:Color.fromRGBO(116,136,168, .2),
  200:Color.fromRGBO(116,136,168, .3),
  300:Color.fromRGBO(116,136,168, .4),
  400:Color.fromRGBO(116,136,168, .5),
  500:Color.fromRGBO(116,136,168, .6),
  600:Color.fromRGBO(116,136,168, .7),
  700:Color.fromRGBO(116,136,168, .8),
  800:Color.fromRGBO(116,136,168, .9),
  900:Color.fromRGBO(116,136,168, 1),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aquila Lite',  
        theme: ThemeData(
          primarySwatch: MaterialColor(0xFF363C44, color),
        ),
        home: App());
  }
}
