import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:saans_app/AllScreen/registrationScreen.dart';
import 'package:saans_app/AllWidgets/progressdialog.dart';
import 'package:saans_app/main.dart';

import 'mainscreen.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen=  "login";
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors. white,
        body: Column(
          children:[
            SizedBox(height: 35.0,),
            Image(
              image: AssetImage("images/logo.png"),
              width: 390.0,
              height: 250.0,
              alignment: Alignment.center,
            ), //LOGIN IMAGE 
            SizedBox(height:1.0,),
            Text(
              "Login",
              style:TextStyle(fontSize:24.0, fontFamily:"Brand Bold"),
              textAlign: TextAlign.center,
            ), //lOGIN TEXT

            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [

                  SizedBox(height:1.0),
                  TextField(
                    controller: emailTextEditingController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:InputDecoration(
                     labelText: "Email",
                      labelStyle: TextStyle(
                         fontSize: 10.0,
                      ), //TEXTSTYLE
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize:10.0,
                      ),//TEXTSTYLE
                     ),  //INPUTDECORATION
                      style: TextStyle(fontSize: 14.0),
                  ),//TEXTFIELD FOR EMAIL

                    SizedBox(height:1.0),
                    TextField(
                      controller: passwordTextEditingController,
                      obscureText: true,
                      decoration:InputDecoration(
                       labelText: "Password",
                        labelStyle: TextStyle(
                            fontSize: 10.0,
                      ), //TEXTSTYLE
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize:10.0,
                      ),//TEXTSTYLE
                     ),  //INPUTDECORATION
                      style: TextStyle(fontSize: 14.0),
                  ),//TEXTFIELD FOR PASSWORD

                  SizedBox(height:10.0,),
                  RaisedButton(
                    color: Colors.red,
                    textColor:Colors.black,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 10.0 , fontFamily:"Brand Bond"),
                        ), //TEXT
                      ),//CENTER
                    ), //CONTAINER
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0), 
                    ), //ROUNDEDBUTTON
                    onPressed: () {
                      if (!emailTextEditingController.text.contains("@")) {
                        displayToastMessage(
                            "Email address is not valid", context);
                      }
                      else if (passwordTextEditingController.text.isEmpty) {
                        displayToastMessage(
                            "Password Field Mandatory ", context);
                      }
                      else {
                        LoginAndAuthenticateUser(context);
                      }
                      },
                  ), //RAISEDBUTTON
                  
                ],
              )
            ), //PADDING
            FlatButton(
              onPressed:(){
                Navigator.pushNamedAndRemoveUntil(context, RegistrationScreen.idScreen , (route) => false);

              },
              child: Text(
                "Don't have an account yet? Register Here"
              ),
            ),
          ],
        ),//COLUMN
    );//SCAFFOLD
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void LoginAndAuthenticateUser(BuildContext context) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context)
        {
          // ignore: missing_return
          return ProgressDialog(message: "Authenticating, Please Wait ......");
        }
    );

    final User firebaseUser = (await _firebaseAuth
        .signInWithEmailAndPassword(
        email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    })).user;

    if (firebaseUser != null) {
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap)
      {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false);
          displayToastMessage("You are logged-in now Successfully!", context);
        }
        else
          {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists for this User. Please create new account!",
              context);
        }
      });
    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("Cannot be Signed In ",context);
    }
  }
}


