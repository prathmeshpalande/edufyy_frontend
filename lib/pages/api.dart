import 'dart:convert';

import 'package:http/http.dart' as http;

class UrlHelper {
  static const String BASE_URL = 'http://192.168.0.11:8080/';

  static String getUrl(String path) {
    return (BASE_URL + path);
  }
}

class BasicResponse {
  final String responseCode;
  final String responseMessage;
  final Map<String, dynamic> responseData;

  BasicResponse({this.responseCode, this.responseMessage, this.responseData});

  factory BasicResponse.from(Map<String, dynamic> json) {
    return BasicResponse(
        responseCode: json['responseCode'].toString(),
        responseMessage: json['responseMessage'],
        responseData: json['responseData']);
  }
}

class LoginResponse {
  final bool isSuccessful;
  final String sessionKey;

  LoginResponse({this.isSuccessful, this.sessionKey});

  factory LoginResponse.from(BasicResponse response) {
    final String sessionKey = response.responseData['sessionKey'];
    return LoginResponse(
        isSuccessful: (response.responseCode == '1'), sessionKey: sessionKey);
  }
}

class SignUpResponse {
  final bool isSuccessful;
  final String sessionKey;
  final String otp;

  SignUpResponse({this.isSuccessful, this.sessionKey, this.otp});

  factory SignUpResponse.from(BasicResponse response) {
    final String otp = response.responseData['otp'];
    final String sessionKey = response.responseData['otp'];
    return SignUpResponse(
        isSuccessful: (response.responseCode == '1'),
        sessionKey: sessionKey,
        otp: otp);
  }
}

class OTPResponse {
  final bool isSuccessful;
  final String sessionKey;

  OTPResponse({this.isSuccessful, this.sessionKey});

  factory OTPResponse.from(BasicResponse response) {
    final String sessionKey = response.responseData['sessionKey'];
    return OTPResponse(
        isSuccessful: (response.responseCode == '1'), sessionKey: sessionKey);
  }
}

Future<LoginResponse> login(String email, String password) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {"email": email, "password": password};

  final response = await http.post(UrlHelper.getUrl("login"),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return LoginResponse.from(BasicResponse.from(json.decode(response.body)));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

Future<SignUpResponse> signUp(String email, String password, String name,
    String phone, String referralCode) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "email": email,
    "password": password,
    "source": referralCode,
    "name": name,
    "phone": phone
  };

  final response = await http.post(UrlHelper.getUrl("signup"),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return SignUpResponse.from(BasicResponse.from(json.decode(response.body)));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

Future<OTPResponse> otp(String otp) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {"otp": otp};

  final response = await http.post(UrlHelper.getUrl("otp"),
      headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return OTPResponse.from(BasicResponse.from(json.decode(response.body)));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

class QuestionsResponse {
  final bool isSuccessful;
  final Map<String, dynamic> data;

  QuestionsResponse({this.isSuccessful, this.data});

  factory QuestionsResponse.from(BasicResponse response) {
    final Map<String, dynamic> questionKeys = response.responseData;
    return QuestionsResponse(
        isSuccessful: (response.responseCode == '1'), data: questionKeys);
  }
}

Future<QuestionsResponse> getQuestionsByKey(
    String sessionKey, String questionKey) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "sessionKey": sessionKey,
    "questionKey": questionKey
  };

  final response = await http.post(UrlHelper.getUrl("get_keys_by_level"),
      headers: headers, body: json.encode(body));
  if (response.statusCode == 200) {
    return QuestionsResponse.from(
        BasicResponse.from(json.decode(response.body)));
  } else {
// If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

class ExamResponse {
  final bool isSuccessful;
  final String data;

  ExamResponse({this.isSuccessful, this.data});

  factory ExamResponse.from(BasicResponse response) {
    final String questions = response.responseData['questions'];
    return ExamResponse(
        isSuccessful: (response.responseCode == '1'), data: questions);
  }
}

Future<QuestionsResponse> getExam(String sessionKey, String questionKey) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "sessionKey": sessionKey,
    "questionKey": questionKey,
    "questionCount": '5'
  };

  final response = await http.post(UrlHelper.getUrl("get_keys_by_level"),
      headers: headers, body: json.encode(body));
  if (response.statusCode == 200) {
    return QuestionsResponse.from(
        BasicResponse.from(json.decode(response.body)));
  } else {
// If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

class AnswerSubmitResponse {
  final bool isCorrect;

  AnswerSubmitResponse({this.isCorrect});

  factory AnswerSubmitResponse.from(BasicResponse response) {
    // print(response.responseData.toString());
    return AnswerSubmitResponse(
      isCorrect: (response.responseCode == '1'),
    );
  }
}

Future<QuestionsResponse> submitAnswer(
    String sessionKey,
    String questionKey,
    String questionNumber,
    String studentDifficulty,
    String surety,
    String answer) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "sessionKey": sessionKey,
    "questionKey": questionKey,
    "questionNumber": questionNumber,
    "studentDifficulty": studentDifficulty,
    "surety": surety,
    "answer": answer
  };

  final response = await http.post(UrlHelper.getUrl("get_keys_by_level"),
      headers: headers, body: json.encode(body));
  if (response.statusCode == 200) {
    return QuestionsResponse.from(
        BasicResponse.from(json.decode(response.body)));
  } else {
// If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}
