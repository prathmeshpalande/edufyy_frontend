import 'dart:async';

import 'package:Edufyy/config/routes/arguments.dart';
import 'package:Edufyy/config/storage.dart';
import 'package:Edufyy/pages/api.dart';
import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    final RouteArguments params = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(params.name),
      ),
      body: ListScreen(params),
    );
  }
}

class ListScreen extends StatefulWidget {
  final RouteArguments params;
  ListScreen(final this.params);

  @override
  State<StatefulWidget> createState() {
    return ListState(params);
  }
}

class ListState extends State<ListScreen> {
  final RouteArguments params;

  ListState(final this.params);

  Widget buildList(BuildContext context, List<ListItem> items) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) => Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureDetector(
                    onTap: () =>
                        openItem(context, items[index].name, items[index].key),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(children: <Widget>[
                            Text(items[index].name,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black)),
                            Container(
                                padding: EdgeInsets.only(top: 16.0),
                                child: FutureBuilder<String>(
                                    future: getProficiencyFor(items[index].key),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError)
                                        return Text(snapshot.error.toString());
                                      else
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.waiting:
                                            return Text(
                                                "Loading proficiency...");
                                          default:
                                            return RichText(
                                                text: TextSpan(
                                                    children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Proficiency: ',
                                                      style: TextStyle(
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: snapshot.data,
                                                      style: TextStyle(
                                                          color: getProficiencyColor(
                                                              double.parse(
                                                                  snapshot
                                                                      .data))))
                                                ]));
                                        }
                                    })),
                          ]),
                          FlatButton(
                            child: Text("Take test"),
                            onPressed: () => startTestFor(
                                context, items[index].name, items[index].key),
                          ),
                        ])))));
  }

  Future<List<ListItem>> getList() async {
    String sessionKey = await FilesHelper("sessionKey").readContent();

    print('in getList() name = ${params.name}; key = ${params.key}');

    QuestionsResponse questionKeyResponse =
    await getQuestionsByKey(sessionKey, params.key);
    List<ListItem> items = [];

    if (params.key == '/')
      questionKeyResponse.data['questionKeys'].forEach((var entry) {
        print(entry['name']);
        items.add(ListItem(
            entry['name'].toString(), entry['questionKey'].toString()));
      });
    else
      questionKeyResponse.data['questionKeys'][0]['questionKeys']
          .forEach((var entry) {
        print(entry['name']);
        items.add(ListItem(
            entry['name'].toString(), entry['questionKey'].toString()));
      });

    return items;
  }

  Color getProficiencyColor(double proficiency) {
    final double t = proficiency * 0.2;
    final String start = Colors.red.value.toRadixString(16).substring(1);
    final String middle = Colors.yellowAccent.value.toRadixString(16).substring(
        1);
    final String end = Colors.green.value.toRadixString(16).substring(1);

    return t >= 0.5
        ? _linear(middle, end, (t - 0.5) * 2)
        : _linear(start, middle, t * 2);
  }

  Color _linear(String s, String e, double x) {
    int r = int.parse(_byteLinear(s[1] + s[2], e[1] + e[2], x));
    int g = int.parse(_byteLinear(s[3] + s[4], e[3] + e[4], x));
    int b = int.parse(_byteLinear(s[5] + s[6], e[5] + e[6], x));
    print('$r $g $b');
    return Color.fromARGB(255, r, g, b);
  }

  String _byteLinear(String a, String b, double x) {
    return (((int.parse(a, radix: 16)) * (1 - x) +
        (((int.parse(b, radix: 16)) * x))))
        .toInt()
        .toString();
  }

  Future<String> getProficiencyFor(String questionKey) async {
    String sessionKey = await FilesHelper("sessionKey").readContent();
    ProficiencyResponse proficiencyResponse =
    await getProficiency(sessionKey, questionKey);

    print(proficiencyResponse.proficiency);
    return proficiencyResponse.proficiency;
  }

  openItem(BuildContext context, String name, String key) {
    print('openItem => name = $name; key = $key');
    Navigator.pushNamed(context, '/list', arguments: RouteArguments(name, key));
  }

  startTestFor(BuildContext context, String name, String questionKey) {
    Navigator.pushNamed(context, '/exam',
        arguments: RouteArguments(name, questionKey));
  }

  @override
  void initState() {
    futureList = getList();
    super.initState();
  }

  Future<List<ListItem>> futureList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListItem>>(
      future: futureList,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return buildList(context, snapshot.data);
        }
      },
    );
  }
}

class ListItem {
  final String name;
  final String key;

  ListItem(final this.name, final this.key);
}
