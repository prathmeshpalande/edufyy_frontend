import 'package:Edufyy/config/routes/arguments.dart';
import 'package:Edufyy/pages/exam.dart';
import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  final String name;

  TopicPage({@required this.name});

  @override
  _TopicPageState createState() => _TopicPageState(name);
}

class _TopicPageState extends State<TopicPage> {
  final String name;

  _TopicPageState(this.name);

  @override
  Widget build(BuildContext context) {
    RouteArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Topic $name'),
      ),
      body: TopicScreen(args),
    );
  }
}

class TopicScreen extends StatefulWidget {
  final RouteArguments args;

  TopicScreen(final this.args);

  @override
  State<StatefulWidget> createState() {
    return TopicState(args);
  }
}

class TopicState extends State<TopicScreen> {
  final RouteArguments args;

  TopicState(final this.args) {
    print(this.args.message);
  }

  @override
  Widget build(BuildContext context) {
    return ExamPage(args); //TODO: make exam page
  }
}
