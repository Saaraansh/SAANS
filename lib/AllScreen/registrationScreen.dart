import 'package:flutter/material.dart';

import 'loginscreen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen=  "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
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
                    controller: nameTextEditingController,
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
                    controller: phoneTextEditingController,
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
                        if(nameTextEditingController.text.length < 3)
                        {
                          displayToastMessage("Name must be atleast 3 characters.", context);
                        }
                        else if(!emailTextEditingController.text.contains("@"))
                        {
                          displayToastMessage("Email address is not valid", context);
                        }
                        else if(phoneTextEditingController.text.isEmpty)
                        {
                          displayToastMessage("Phone Number is mandatory", context);
                        }
                        else if(passwordTextEditingController.text.length < 6)
                        {
                          displayToastMessage("Password must be atleast 6 characters", context);
                        }
                        else
                        {
                          registerNewUser(context);
                        }
                      }, 
                  ), //RAISEDBUTTON

                ],
              )
          ), //PADDING
          FlatButton(
            onPressed:(){
              Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
            },
            child: Text(
                "Already have an account yet? Login Here"
            ),
          ),
        ],
      ),//COLUMN
    );//SCAFFOLD
  }
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async
  {
    final User firebaseUser = (await _firebaseAuth
      .createUserWithEmailAndPassword(
      email: emailTextEditingController.text, 
      password: passwordTextEditingController.text 
      ).catchError((errMsg){
        displayToastMessage("Error: " + errMsg.toString(),context);
      })).user;

      if(firebaseUser != null) //user created
      {
        //error user info to database
         Map userDataMap = {
          "name": nameTextEditingController.text.trim(),
          "email": emailTextEditingController.text.trim(),
          "phone": phoneTextEditingController.text.trim(),
        }
        usersRef.child(firebaseUser.uid).set(userDataMap);
        displayToastMessage("Congratulations, your account has been created", context);

        Navigator.pushNamedAndRemoveUntil(context, MainScreen.idScreen, (route) => false);
      }
      else
      {
        //error occured - display eeror msg
        displayToastMessage("New user account has not been Created",context);
      }
  }
}
displayToastMessage(String message, BuildContext context)
{
  Fluttertoast.showToast(msg: message);
}
