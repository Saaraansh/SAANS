import 'package:flutter/material.dart';
import 'package:saans_app/AllScreen/mainscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAANS',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
      ),
      home: MainScreen() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

