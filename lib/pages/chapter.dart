import 'package:Edufyy/config/routes/arguments.dart';
import 'package:flutter/material.dart';

class ChapterPage extends StatefulWidget {
  final String name;

  ChapterPage({@required this.name});

  @override
  _ChapterPageState createState() => _ChapterPageState(name);
}

class _ChapterPageState extends State<ChapterPage> {
  final String name;

  _ChapterPageState(final this.name);

  @override
  Widget build(BuildContext context) {
    RouteArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chapter $name'),
      ),
      body: ChapterScreen(args),
    );
  }
}

class ChapterScreen extends StatefulWidget {
  final RouteArguments args;

  ChapterScreen(final this.args);

  @override
  State<StatefulWidget> createState() {
    return ChapterState(args);
  }
}

class ChapterState extends State<ChapterScreen> {
  RouteArguments args;

  var listBuilder;
  static List<String> topics = getListOf("Topic ", 25);

  ChapterState(args) {
    this.args = args;

    listBuilder = ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) => Card(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () => openTopic(context, index + 1),
                    child: Text(
                      topics[index],
                      style: TextStyle(
                          fontFamily: "monospace",
                          fontSize: 18.0,
                          color: Colors.black),
                    ),
                  )),
            ));
  }

  openTopic(BuildContext context, int index) {
    Navigator.pushNamed(context, '${args.message}/$index',
        arguments: RouteArguments('${args.message}/$index'));
  }

  static getListOf(String label, int count) {
    int i = 0;
    List<String> list = new List(count);
    while (i < count) {
      list[i] = label + (i + 1).toString();
      i++;
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return listBuilder;
  }
}
