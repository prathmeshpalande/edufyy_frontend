import 'package:Edufyy/config/routes/arguments.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  @override
  _ExamPageState createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  RouteArguments params;

  @override
  Widget build(BuildContext context) {
    params = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(params.name),
      ),
      body: Center(
        child: Text("Exam page"),
      ),
    );
  }
}
