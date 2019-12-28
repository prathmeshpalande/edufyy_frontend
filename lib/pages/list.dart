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

  ListState(final this.params) {
    print('name = ${params.name}; key = ${params.key}');
  }

  Widget buildList(BuildContext context, List<ListItem> items) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) =>
            Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () =>
                          openItem(
                              context, items[index].name, items[index].key),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(items[index].name,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Row(
                              children: <Widget>[
                                Text("proficiency: TODO"),
                                FlatButton(
                                  child: Text("Take test"),
                                  onPressed: () =>
                                      startTestFor(context,
                                          items[index].name, items[index].key),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))));
  }

  Future<List<ListItem>> getList() async {
    String sessionKey = await FilesHelper("sessionKey").readContent();

    print('in getList() name = ${params.name}; key = ${params.key}');
    QuestionsResponse questionKeyResponse;
    questionKeyResponse = await getQuestionsByKey(sessionKey, params.key);

    List<ListItem> items = [];
    questionKeyResponse.data['questionKeys'].forEach((var entry) {
      print(entry['name']);
      items.add(
          ListItem(
              entry['name'].toString(),
              entry['questionKey'].toString()));
    }
    );


    return items;
  }

  openItem(BuildContext context, String name, String key) {
    print('openItem => name = $name; key = $key');
    Navigator.pushNamed(context, '/list',
        arguments: RouteArguments(name, key));
  }

  startTestFor(BuildContext context, String name, String questionKey) {
    Navigator.pushNamed(context, '/exam',
        arguments: RouteArguments(name, questionKey));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ListItem>>(
      future: getList(),
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
