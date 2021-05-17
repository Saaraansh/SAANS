import 'package:flutter/material.dart';

class RegistrationScreen extends StatelessWidget {
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
            "Register here",
            style:TextStyle(fontSize:24.0, fontFamily:"Brand Bold"),
            textAlign: TextAlign.center,
          ), //TEXT

          Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height:1.0),
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration:InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 10.0,
                      ), //TEXTSTYLE
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize:10.0,
                      ),//TEXTSTYLE
                    ),  //INPUTDECORATION
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height:1.0),
                  TextField(
                    keyboardType: TextInputType.phone,
                    decoration:InputDecoration(
                      labelText: "Mobile Number",
                      labelStyle: TextStyle(
                        fontSize: 10.0,
                      ), //TEXTSTYLE
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize:10.0,
                      ),//TEXTSTYLE
                    ),  //INPUTDECORATION
                    style: TextStyle(fontSize: 14.0),
                  ),


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
                            "Create an account",
                            style: TextStyle(fontSize: 10.0 , fontFamily:"Brand Bond"),
                          ), //TEXT
                        ),//CENTER
                      ), //CONTAINER
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(24.0),
                      ), //ROUNDEDBUTTONg
                      onPressed: ()
                      {
                        print("Logged in as a guest");
                      }
                  ), //RAISEDBUTTON

                ],
              )
          ), //PADDING
          FlatButton(
            onPressed:(){
              print("Logged In Button Clicked");
            },
            child: Text(
                "Already have an account yet? Login Here"
            ),
          ),
        ],
      ),//COLUMN
    );//SCAFFOLD
  }
}