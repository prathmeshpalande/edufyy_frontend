import 'package:Edufyy/config/application.dart';
import 'package:Edufyy/config/storage.dart';
import 'package:Edufyy/pages/api.dart';
import 'package:flutter/material.dart';

class SubjectsPage extends StatefulWidget {
  @override
  _SubjectsPageState createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Subjects"),
      ),
      body: SubjectsScreen(),
    );
  }
}

class SubjectsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SubjectsState();
  }
}

class SubjectsState extends State<SubjectsScreen> {
  Widget buildSubjectsList(BuildContext context, List<String> subjects) {
    return subjects == null
        ? Text("No subjects")
        : ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) => Card(
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => openSubject(context, index + 1),
                      child: Text(
                        subjects[index],
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ))));
  }

  Future<List<String>> getSubjectsList() async {
    String sessionKey = await FilesHelper("sessionKey").readContent();

    QuestionsResponse questionKey = await getQuestionsByKey(sessionKey, '0');

    var keysList = (questionKey.data['questionKeys'] as List);

    FilesHelper('QuestionKeys').writeContent(keysList.toString());

    List<String> subjects = [];
    keysList.forEach((var entry) {
      if ((entry as Map)['questionKey'].toString().split('/').length == 1)
        subjects.add((entry as Map)['name']);
    });

    return subjects;
  }

  openSubject(BuildContext context, int index) {
    Application.router.navigateTo(context, '/subjects/$index');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: getSubjectsList(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          default:
            return buildSubjectsList(context, snapshot.data);
        }
      },
    );
  }
}
