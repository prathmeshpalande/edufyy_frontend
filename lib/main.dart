import 'package:Edufyy/pages/exam.dart';
import 'package:Edufyy/pages/list.dart';
import 'package:Edufyy/pages/login.dart';
import 'package:Edufyy/pages/otp.dart';
import 'package:Edufyy/pages/signup.dart';
import 'package:flutter/material.dart';

class AppComponent extends StatefulWidget {
  @override
  State createState() {
    return AppComponentState();
  }
}

class AppComponentState extends State<AppComponent> {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/otp': (context) => OtpPage(),
        '/list': (context) => ListPage(),
        '/exam': (context) => ExamPage(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
    );

    return app;
  }
}

void main() => runApp(AppComponent());
