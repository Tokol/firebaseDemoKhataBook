import 'package:fbdemo03/screens/auth/registration.dart';
import 'package:fbdemo03/screens/auth/user_login.dart';
import 'package:fbdemo03/screens/dashboard/home_screen.dart';
import 'package:fbdemo03/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FireBase DEmo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[200],

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: SplashScreen.id,
      routes:{
        SplashScreen.id:(context)=>SplashScreen(),
        UserRegistration.id:(context)=>UserRegistration(),
        UserLogin.id:(context)=>UserLogin(),
        HomeScreen.id:(context)=>HomeScreen()

      }
    );
  }
}

