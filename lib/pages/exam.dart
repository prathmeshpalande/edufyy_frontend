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
  List<Answer> answers = [];

  @override
  void initState() {
    examDataFuture = getExamData();
    questionIndex = 0;
    _answerOption = AnswerOptions.OPTION_A;
    _sure = 4.0;
    _diff = 0.0;
    _proceedButtonText = 'Next';
    super.initState();
  }

  double _diff = 0.0,
      _sure = 4.0;
  String studentDifficulty;
  String surety;
  String _proceedButtonText = 'Next';

  AnswerOptions _answerOption;

  _onDifficultyChanged(double newValue) {
    studentDifficulty = newValue.toString();
  }

  _onSuretyChanged(double newValue) {
    surety = newValue.toString();
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
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Question number ' +
                                  (questionIndex + 1).toString() +
                                  ' out of 5'),
                              Text('From ' +
                                  snapshot.data[questionIndex]['questionKey']),
                              Text(snapshot.data[questionIndex]['question'])
                            ]),
                        buildExamOptionsList(snapshot.data, questionIndex),
                        Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text('Difficulty'),
                              Slider(
                                activeColor: Theme
                                    .of(context)
                                    .accentColor,
                                inactiveColor: Theme
                                    .of(context)
                                    .primaryColor,
                                divisions: 4,
                                min: 0.0,
                                max: 4.0,
                                onChanged: (double newValue) {
                                  setState(() {
                                    _diff = newValue;
                                  });
                                  _onDifficultyChanged(newValue);
                                },
                                value: _diff,
                              ),
                              Text(_diff.toString())
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text('Surety'),
                              Slider(
                                  activeColor: Theme
                                      .of(context)
                                      .accentColor,
                                  inactiveColor: Theme
                                      .of(context)
                                      .primaryColor,
                                  min: 0.0,
                                  max: 4.0,
                                  divisions: 4,
                                  onChanged: (double newValue) {
                                    setState(() {
                                      _sure = newValue;
                                    });
                                    _onSuretyChanged(newValue);
                                  },
                                  value: _sure),
                              Text(_sure.toString())
                            ],
                          )
                        ]),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                                color: Theme
                                    .of(context)
                                    .accentColor,
                                child: Text(_proceedButtonText),
                                onPressed: () {
                                  String answer;
                                  switch (_answerOption) {
                                    case AnswerOptions.OPTION_A:
                                      answer = 'A';
                                      break;
                                    case AnswerOptions.OPTION_B:
                                      answer = 'B';
                                      break;
                                    case AnswerOptions.OPTION_C:
                                      answer = 'C';
                                      break;
                                    case AnswerOptions.OPTION_D:
                                      answer = 'D';
                                      break;
                                  }
                                  _selectAnswer(snapshot.data,
                                      studentDifficulty, surety, answer);
                                })
                          ],
                        )
                      ]);
              }
            }));
  }

  Future<List> getExamData() async {
    String sessionKey = await FilesHelper("sessionKey").readContent();
    ExamResponse examResponse =
        await getExam(sessionKey, params.key, 5.toString());

    examResponse.data
        .sort((a, b) => a['questionNumber'].compareTo(b['questionNumber']));
    return examResponse.data;
  }

  Widget buildExamOptionsList(List options, int questionIndex) {
    return Column(children: <Widget>[
      RadioListTile(
          value: AnswerOptions.OPTION_A,
          title: Text(options[questionIndex]['optionA']),
          groupValue: _answerOption,
          onChanged: (AnswerOptions option) {
            setState(() {
              _answerOption = option;
            });
          }),
      RadioListTile(
          value: AnswerOptions.OPTION_B,
          title: Text(options[questionIndex]['optionB']),
          groupValue: _answerOption,
          onChanged: (AnswerOptions option) {
            setState(() {
              _answerOption = option;
            });
          }),
      RadioListTile(
          value: AnswerOptions.OPTION_C,
          title: Text(options[questionIndex]['optionC']),
          groupValue: _answerOption,
          onChanged: (AnswerOptions option) {
            setState(() {
              _answerOption = option;
            });
          }),
      RadioListTile(
          value: AnswerOptions.OPTION_D,
          title: Text(options[questionIndex]['optionD']),
          groupValue: _answerOption,
          onChanged: (AnswerOptions option) {
            setState(() {
              _answerOption = option;
            });
          })
    ]);
  }

  Future<List<AnswerResponse>> _submitAnswers(List<Answer> answers) async {
    String sessionKey = await FilesHelper('sessionKey').readContent();
    List<AnswerResponse> answerResponses = [];
    for (Answer a in answers) {
      AnswerSubmitResponse answerSubmitResponse = await submitAnswer(
          sessionKey,
          a.questionKey,
          a.questionNumber,
          a.studentDifficulty,
          a.surety,
          a.answer);
      answerResponses.add(
          AnswerResponse(answerSubmitResponse.isCorrect, a.questionNumber));
    }
    return answerResponses;
  }

  _selectAnswer(List options, String studentDifficulty,
      String surety, String answer) {
    if (studentDifficulty == null || surety == null) return;
    if (questionIndex != 4) {
      answers.add(Answer(
          options[questionIndex]['questionKey'],
          options[questionIndex]['questionNumber'].toString(),
          studentDifficulty,
          surety,
          answer));
      setState(() {
        questionIndex++;
        if (questionIndex == 4)
          _proceedButtonText = 'Submit';
      });
    } else
      _submitAnswers(answers);
  }
}

class Answer {
  final String questionKey;
  final String questionNumber;
  final String studentDifficulty;
  final String surety;
  final String answer;

  Answer(final this.questionKey, final this.questionNumber,
      final this.studentDifficulty, final this.surety, final this.answer);
}

class AnswerResponse {
  final bool isCorrect;
  final String questionNumber;

  AnswerResponse(final this.isCorrect, final this.questionNumber);
}

enum AnswerOptions {
  OPTION_A,
  OPTION_B,
  OPTION_C,
  OPTION_D,
}
