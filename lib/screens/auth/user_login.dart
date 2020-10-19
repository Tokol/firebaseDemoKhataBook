import 'package:fbdemo03/screens/auth/registration.dart';
import 'package:fbdemo03/screens/dashboard/home_screen.dart';
import 'package:fbdemo03/widget/custome_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class UserLogin extends StatefulWidget {
  static final String id = "USER_LOGIN_SCREEN";
  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  String username;
  String password;
  FirebaseAuth _auth = FirebaseAuth.instance;

bool loading = false;



void userLogin()async{
  try{
    setState(() {
      loading = true;
    });
    var user = await _auth.signInWithEmailAndPassword(email: username, password: password);
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
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(

        child: Column(
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
               onPressed: ()  {
                 userLogin();
               },
               child: Container(
                 padding: EdgeInsets.all(20.0),
                 width: MediaQuery.of(context).size.width - 100,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
                 ),
                 child: Text(
                   'Login',
                   textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.black26),
                 ),
               )),


            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, UserRegistration.id);
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      child: Text('Create Account? ')),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
