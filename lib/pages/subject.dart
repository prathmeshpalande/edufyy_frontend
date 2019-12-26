import 'package:Edufyy/config/routes/arguments.dart';
import 'package:Edufyy/config/storage.dart';
import 'package:flutter/material.dart';

class SubjectPage extends StatefulWidget {
  final String name;

  SubjectPage({@required final this.name});

  @override
  _SubjectPageState createState() => _SubjectPageState(name);
}

class _SubjectPageState extends State<SubjectPage> {
  final String name;

  _SubjectPageState(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subject $name"),
      ),
      body: SubjectScreen(name),
    );
  }
}

class SubjectScreen extends StatefulWidget {
  final String name;

  SubjectScreen(this.name);

  @override
  State<StatefulWidget> createState() {
    return SubjectState(name);
  }
}

class SubjectState extends State<SubjectScreen> {
  final String name;
  var listBuilder;

  SubjectState(final this.name);

  openChapter(BuildContext context, int index) {
    Navigator.pushNamed(context, 'subjects/$name/$index',
        arguments: RouteArguments('subjects/$name/$index'));
  }

  Widget buildChaptersList(BuildContext context, List<String> chapters) {
    return ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) => Card(
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () => openChapter(context, index + 1),
                  child: Text(
                    chapters[index],
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ))));
  }

  Future<List<String>> getChaptersList() async {
    var keysList = await FilesHelper('QuestionKeys').readContent() as List;
    print(keysList.toString());

    List<String> chapters = ['', ''];
    keysList.forEach((var entry) {
      if ((entry as Map)['questionKey'].toString().split('/').length == 1)
        //chapters.add((entry as Map)['name']);
        print((entry as Map)['name']);
    });

    return chapters;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getChaptersList(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return buildChaptersList(context, snapshot.data);
        }
      },
    );
  }
}
