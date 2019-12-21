import 'package:Edufyy/otp.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';

void main() => runApp(EdufyyApp());

class EdufyyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
    initialRoute: '/',
    routes: {
      '/': (context) => LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/otp': (context) => OtpPage(),
      '/homePage': (context) => HomePage(),
    }
    );
  }
}


