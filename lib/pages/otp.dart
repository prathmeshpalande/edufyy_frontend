import 'package:Edufyy/config/routes/arguments.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  List<String> data;

  onOtpSubmit(String otp) {
    if (otp == data[1])
      Navigator.pushNamed(
          context, '/list', arguments: RouteArguments('Subjects', '0'));

    //TODO: handle invalid otp
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute
        .of(context)
        .settings
        .arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Enter OTP"),
        ),
        body: Center(
          child: TextField(
            maxLength: 4,
            maxLengthEnforced: true,
            style: TextStyle(fontSize: 32.0, letterSpacing: 16.0),
            textAlign: TextAlign.center,
            onSubmitted: (text) => onOtpSubmit(text),
            keyboardType:
            TextInputType.numberWithOptions(signed: false, decimal: false),
            decoration: InputDecoration(
              counterText: "",
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).accentColor, width: 2.4)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.4)),
            ),
          ),
        ));
  }
}
