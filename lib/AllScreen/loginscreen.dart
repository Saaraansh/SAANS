import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.white,
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
              padding: EdgeInsert.all(20.0),
              child: Column(
                children: [

                  SizedBox(height:1.0),
                  TextField(
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
                      obscureText: True,
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
                  RasiedButton(
                    color: Colors.red,
                    textColor:Colors.black,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 10.0,, fontFamily:"Brand Bond"),
                        ), //TEXT
                      ),//CENTER
                    ), //CONTAINER
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0), 
                    ), //ROUNDEDBUTTON
                    onPressed: ()
                    {
                      print("Logged in as a guest")
                    }
                  ), //RAISEDBUTTON
                  
                ],
              )
            ), //PADDING
            FlatButton(
              onPressed:(){
                print("Logged In")
              },
              child: Text(
                "Don't have an account yet? Register Here"
              ),
            ),
          ],
        ),//COLUMN
    );//SCAFFOLD
  }
}

