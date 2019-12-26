import 'package:Edufyy/pages/chapter.dart';
import 'package:Edufyy/pages/login.dart';
import 'package:Edufyy/pages/otp.dart';
import 'package:Edufyy/pages/signup.dart';
import 'package:Edufyy/pages/subject.dart';
import 'package:Edufyy/pages/subjects.dart';
import 'package:Edufyy/pages/topic.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var signUpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SignUpPage();
});
var otpHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return OtpPage();
});
var subjectsHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SubjectsPage();
});

var subjectHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return SubjectPage(name: params["subject"][0]);
});

var chapterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ChapterPage(name: params["chapter"][0]);
});

var topicHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TopicPage(name: params["topic"][0]);
});
