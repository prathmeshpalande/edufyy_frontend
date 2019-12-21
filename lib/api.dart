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
      responseData: json
    );
  }
}

class LoginResponse {
  final bool isSuccessful;
  final String sessionKey;

  LoginResponse({this.isSuccessful, this.sessionKey});

  factory LoginResponse.from(BasicResponse response) {
    print(response.responseData.toString());
    return LoginResponse(
        isSuccessful: (response.responseCode == '1'),
        sessionKey: response.responseData['sessionKey'].toString()
    );
  }
}

class SignUpResponse {
  final bool isSuccessful;
  final String sessionKey;

  SignUpResponse({this.isSuccessful, this.sessionKey});

  factory SignUpResponse.from(BasicResponse response) {
    print(response.responseData.toString());
    return SignUpResponse(
        isSuccessful: (response.responseCode == '1'),
        sessionKey: response.responseData['sessionKey'].toString()
    );
  }
}

class OTPResponse {
  final bool isSuccessful;
  final String sessionKey;

  OTPResponse({this.isSuccessful, this.sessionKey});

  factory OTPResponse.from(BasicResponse response) {
    print(response.responseData.toString());
    return OTPResponse(
        isSuccessful: (response.responseCode == '1'),
        sessionKey: response.responseData['sessionKey'].toString()
    );
  }
}

Future<LoginResponse> login(String email, String password) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "email": email,
    "password": password
  };

  final response =
  await http.post(UrlHelper.getUrl("login"),
      headers: headers,
      body: json.encode(body)
  );

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return LoginResponse.from(
      BasicResponse.from(json.decode(response.body))
    );
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

Future<SignUpResponse> signUp(String email, String password, String name, String phone, String referralCode) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "email": email,
    "password": password,
    "source": referralCode,
    "name": name,
    "phone": phone
  };

  final response =
  await http.post(UrlHelper.getUrl("signup"),
      headers: headers,
      body: json.encode(body)
  );

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return SignUpResponse.from(
        BasicResponse.from(json.decode(response.body))
    );
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}

Future<OTPResponse> otp(String otp) async {
  Map<String, String> headers = {"Content-type": "application/json"};
  Map<String, String> body = {
    "otp": otp
  };

  final response =
  await http.post(UrlHelper.getUrl("otp"),
      headers: headers,
      body: json.encode(body)
  );

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    return OTPResponse.from(
        BasicResponse.from(json.decode(response.body))
    );
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load response');
  }
}