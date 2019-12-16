import 'dart:convert';
import 'package:http/http.dart' as http;

final String BASE_URL = '192.168.0.11:80/';

class Api {
  Future<http.Response> get(String path) {
    return http.get(BASE_URL + path);
  }
}

class BasicResponse {
  final String email;
  final String password;
  final String sessionKey;

  BasicResponse({this.email, this.password, this.sessionKey});

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      email: json['email'],
      password: json['password'],
      sessionKey: json['session_key']
    );
  }
}

Future<BasicResponse> fetch(String path) async {
  final response =
  await http.get(BASE_URL + path);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return BasicResponse.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}