import 'package:flutter/material.dart';
import 'api.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _pwd2Controller = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _referralController = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailController.dispose();
    _pwdController.dispose();
    _pwd2Controller.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  onRegister() {

    if (_formKey.currentState.validate()) {
      final String email = _emailController.text;
      final String pwd = _pwdController.text;
      final String name = _nameController.text;
      final String phone = _phoneController.text;
      final String referralCode = _referralController.text;
      Future<SignUpResponse> response = signUp(
          email, pwd, name, phone, referralCode);
      response
          .then((SignUpResponse signUpResponse) {
        //TODO: validate response
        Navigator.pushNamed(context, '/otp');
      })
          .catchError((exception) {
        print(exception.toString());
      });
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign up"),
        ),
        body: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Form(
                      key: _formKey,
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please don\'t leave this blank';
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
                                      borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please don\'t leave this blank';
                                  }
                                  return null;
                                },
                                controller: _pwdController,
                                autofocus: true,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please don\'t leave this blank';
                                  } else if(value != _pwdController.text) {
                                    return 'Passwords don\'t match';
                                  }
                                  return null;
                                },
                                controller: _pwd2Controller,
                                autofocus: true,
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Repeat Password",
                                  hintText: "Password",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please don\'t leave this blank';
                                  }
                                  return null;
                                },
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: "Name",
                                  hintText: "Name Surname",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please don\'t leave this blank';
                                  } else if(value.length != 10) {
                                    return 'Invalid length';
                                  }
                                  return null;
                                },
                                controller: _phoneController,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed:  false, decimal: false
                                ),
                                maxLength: 10,
                                decoration: InputDecoration(
                                  labelText: "Phone",
                                  hintText: "1234567890",
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                  focusedErrorBorder:  OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red, width: 2.0)
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child:RaisedButton(
                                      child: Text("Register"),
                                      onPressed: onRegister,
                                      color: Theme
                                          .of(context)
                                          .primaryColor,
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
                                    ),
                                  )
                                ],
                              ),
                              margin: EdgeInsets.only(bottom: 16.0),
                            ),
                          ]
                      )
                  )
              ),
            ]
        )
    );
  }
}