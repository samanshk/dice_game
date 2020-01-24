import 'Home.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new Home(),
      title: new Text('Dice Game',
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 60.0,
        color: Colors.white
      ),),
      image: new Image.asset('assets/home.png'),
      backgroundColor: Colors.purple,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 80.0,
      // onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.white
    );
  }
}


