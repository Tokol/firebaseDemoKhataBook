import 'package:fbdemo03/screens/auth/user_login.dart';
import 'package:fbdemo03/screens/dashboard/home_screen.dart';
import 'package:fbdemo03/widget/custome_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';
class UserRegistration extends StatefulWidget {
  static final String id = "REGISTRATION_SCREEN";

  @override
  _UserRegistrationState createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  String username;
  String password;
  bool loading = false;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void userRegistration()async{
    try{
      setState(() {
        loading = true;
      });
      var user = await _auth.createUserWithEmailAndPassword(email: username, password: password);
      setState(() {
        loading = false;
      });

      if(user!=null){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        try{
          prefs.setBool(KUserLoginKey,true);
          prefs.setString(KUserEmail, username);
          Navigator.pushReplacementNamed(context, HomeScreen.id);

        }
        catch(e){

          print(e.toString());
        }

      }

      else{
        print('No user Found!!');

      }}


    catch(e){
      setState(() {
        loading = false;
      });
      print(e.toString());
    }


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text('Registration'),),
      body:  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FireBaseText(
          hint: "User Name",
          onChanged: (value) {
            username = value;
          },
        ),
        FireBaseText(
          hint: "Password",
          showText: true,
          onChanged: (value) {
            password = value;
          },
        ),
       loading?CircularProgressIndicator(): RaisedButton(
           color: Colors.greenAccent,
           highlightColor: Colors.yellowAccent,
           onPressed: () {

             userRegistration();

           },
           child: Container(
             padding: EdgeInsets.all(20.0),
             width: MediaQuery.of(context).size.width - 100,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(30.0)),
             ),
             child: Text(
               'Register',
               textAlign: TextAlign.center,
               style: TextStyle(color: Colors.black26),
             ),
           )),

        GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, UserLogin.id);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                  child: Text('Already have Account? Login Now ')),
            ),
          ),
        )


      ],
    ),
    );
  }
}
