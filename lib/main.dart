import 'package:flutter/material.dart';
import 'package:saans_app/AllScreen/mainscreen.dart';
import 'package:saans_app/AllScreen/loginscreen.dart';
import 'package:saans_app/AllScreen/registrationScreen.dart';

import 'AllScreen/loginscreen.dart';
import 'AllScreen/loginscreen.dart';


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
      initialRoute: LoginScreen .idScreen,
      routes:
          {
          RegistrationScreen.idScreen: (context) => RegistrationScreen(),
            LoginScreen.idScreen: (context) => LoginScreen(),
            MainScreen.idScreen: (context) => MainScreen(),
          },
      debugShowCheckedModeBanner: false,
    );
  }
}

