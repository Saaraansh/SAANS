import 'package:flutter/material.dart';
import 'package:saans_app/AllScreen/mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterDemo',
      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      home: MainScreen() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

