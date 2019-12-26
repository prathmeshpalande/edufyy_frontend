import 'package:Edufyy/config/routes/arguments.dart';
import 'package:flutter/material.dart';

class ExamPage extends StatefulWidget {
  final RouteArguments args;

  ExamPage(final this.args);

  @override
  _ExamPageState createState() => _ExamPageState(args);
}

class _ExamPageState extends State<ExamPage> {
  final RouteArguments args;

  _ExamPageState(final this.args);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: <Widget>[],
    );
  }
}
