
import 'package:fbdemo03/config.dart';
import 'package:fbdemo03/screens/auth/user_login.dart';
import 'package:fbdemo03/screens/dashboard/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static final String id  = "SPLASH_SCREEN";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }



  void checkUserLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

   try{
     bool userLogin = prefs.getBool(KUserLoginKey);

     if(userLogin){
       Navigator.pushReplacementNamed(context, HomeScreen.id);
     }

     else{
       Navigator.pushReplacementNamed(context, UserLogin.id);
     }

   }

   catch(e){
     Navigator.pushReplacementNamed(context, UserLogin.id);
   }



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(child: Text('Loading......'),),
    );
  }
}
