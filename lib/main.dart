import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:saans_app/AllScreen/mainscreen.dart';
import 'package:saans_app/AllScreen/loginscreen.dart';
import 'package:saans_app/AllScreen/registrationScreen.dart';

import 'AllScreen/loginscreen.dart';
import 'AllScreen/loginscreen.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference usersRef = FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAANS',
      theme: ThemeData(
        fontFamily: "Brand Bold",
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.idScreen,
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

