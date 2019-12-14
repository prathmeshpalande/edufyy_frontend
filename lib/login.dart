import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          )
        )
    );
  }
}

class LoginForm extends StatefulWidget{
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

  onLogin() {
    final String email = _emailController.text;
    final String pwd = _pwdController.text;
    // TODO: attempt login
  }

  onSignUp() {
    Navigator.pushNamed(context, '/signup');
  }
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
            children: <Widget> [
              Column(
                  children: <Widget> [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
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
                              borderSide: BorderSide(color:  Theme.of(context).accentColor, width: 2.0)
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:  Theme.of(context).primaryColor, width: 2.0)
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                  ]
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child:RaisedButton(
                        child: Text("Login"),
                        onPressed: onLogin,
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
              Row(
                  children: <Widget>[
                    Expanded(
                      child: InkWell(
                        child: Text("Create Account",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xaa242424)
                          ),
                        ),
                        onTap: onSignUp,
                      ),
                    ),
                    Expanded(
                      child:Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child: Text("Forgot Password?",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color(0xaa242424)
                              )
                          ),
                          onTap: onSignUp,
                        ),
                      ),
                    )
                  ]
              ),
            ]
        )
    );
  }
}
