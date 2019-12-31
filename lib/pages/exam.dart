import 'package:Edufyy/config/routes/arguments.dart';
import 'package:Edufyy/config/storage.dart';
import 'package:Edufyy/pages/api.dart';
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
          title: Text('Exam for ' + params.name),
        ),
        body: ExamScreen(params));
  }
}

class ExamScreen extends StatefulWidget {
  final RouteArguments params;

  ExamScreen(final this.params);

  @override
  State<StatefulWidget> createState() {
    return ExamState(params);
  }
}

class ExamState extends State<ExamScreen> {
  final RouteArguments params;

  ExamState(final this.params);

  int questionIndex;
  Future<List> examDataFuture;
  String sessionKey;

  getSessionKey() async {
    return await FilesHelper("sessionKey").readContent();
  }

  @override
  void initState() {
    sessionKey = getSessionKey();
    examDataFuture = getExamData();
    questionIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List>(
            future: examDataFuture,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  snapshot.data.sort((a, b) =>
                      a['questionNumber'].compareTo(b['questionNumber']));
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Question number ' +
                            snapshot.data[questionIndex]['questionNumber']
                                .toString() +
                            ' out of 5'),
                        Text('From ' +
                            snapshot.data[questionIndex]['questionKey']),

                        Text(snapshot.data[questionIndex]['question']),
                        buildExamOptionsList(snapshot.data, questionIndex),
                        //Slider()
                      ]);
              }
            }));
  }

  Future<List> getExamData() async {
    String sessionKey = await FilesHelper("sessionKey").readContent();
    ExamResponse examResponse =
        await getExam(sessionKey, params.key, 5.toString());

    print(examResponse.data);
    return examResponse.data;
  }

  Widget buildExamOptionsList(List options, int questionIndex) {
    return ListView(shrinkWrap: true, children: <Widget>[
      Card(
          child: GestureDetector(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(options[questionIndex]['optionA'])),
      )),
      Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(options[questionIndex]['optionB'])),
      ),
      Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(options[questionIndex]['optionC'])),
      ),
      Card(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(options[questionIndex]['optionD'])),
      ),
    ]);
  }

  _submitAnswer(String questionKey, String questionNumber,
      String studentDifficulty, String surety, String answer) async {
    AnswerSubmitResponse answerSubmitResponse = await submitAnswer(sessionKey,
        questionKey, questionNumber, studentDifficulty, surety, answer);
  }

  _selectAnswer(List options, int questionIndex) {
    //TODO: do something
  }
}
