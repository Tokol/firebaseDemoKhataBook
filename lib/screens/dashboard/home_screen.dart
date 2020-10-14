import 'package:fbdemo03/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class HomeScreen extends StatefulWidget {
  static final String id = "HOME_SCREEN";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  printEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(KUserEmail));
  }

  @override
  void initState() {
    printEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              //request to logout in server;
              prefs.setBool(KUserLoginKey, false);
              prefs.setString(KUserEmail, null);
              Navigator.pushReplacementNamed(context, SplashScreen.id);
            },
          )
        ],
      ),





    );
  }
}
