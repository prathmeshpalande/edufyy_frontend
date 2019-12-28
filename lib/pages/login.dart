import 'package:Edufyy/config/routes/arguments.dart';
import 'package:Edufyy/config/storage.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _ipAddressController;

  _LoginPageState() {
    _ipAddressController = TextEditingController();
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Server IP address and port"),
      content: TextField(
        controller: _ipAddressController,
      ),
      actions: [
        FlatButton(
          child: Text("OK"),
          onPressed: () => UrlHelper().setUrl(_ipAddressController.text),
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (String s) {
                showAlertDialog(context);
              },
              itemBuilder: (BuildContext context) {
                List<String> choices = ['IP address'];
                return choices.map((String s) {
                  return PopupMenuItem<String>(
                    value: s,
                    child: Text(s),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(24.0),
                  child: LoginForm(),
                )
              ],
            )));
  }
}

class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _pwdController.dispose();
    super.dispose();
  }

  onLogin() async {
    if (_formKey.currentState.validate()) {
      final String email = _emailController.text;
      final String password = _pwdController.text;

      try {
        LoginResponse loginResponse = await login(email, password);
        if (loginResponse.isSuccessful) {
          await FilesHelper("sessionKey")
              .writeContent(loginResponse.sessionKey);
          print(loginResponse.sessionKey);
          Navigator.pushNamed(context, '/list',
              arguments: RouteArguments('Subjects', '/'));
        } else {
          //TODO: handle unsuccessful login attempt
        }
      } on Exception catch (e) {
        print(e.toString());
      }
    }
  }

  onSignUp() {
    Navigator.pushNamed(context, '/signup');
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter email';
                  } else if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                controller: _emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "email@example.com",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormField(
                controller: _pwdController,
                obscureText: true,
                onEditingComplete: onLogin,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor, width: 2.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 2.0)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 2.0)),
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please don\'t leave this blank';
                  }
                  return null;
                },
              ),
            ),
          ]),
          Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text("Login"),
                    onPressed: () => onLogin(),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                  ),
                )
              ],
            ),
            margin: EdgeInsets.only(bottom: 16.0),
          ),
          Row(children: <Widget>[
            Expanded(
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Create Account",
                    style: TextStyle(fontSize: 12, color: Color(0xaa242424)),
                  ),
                ),
                onTap: () => onSignUp(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              fontSize: 12, color: Color(0xaa242424)))),
                  //TODO: onTap
                ),
              ),
            )
          ]),
        ]));
  }
}
