import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {

  onOtpSubmit(String otp) {
    //TODO: implement this
    print(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter OTP"),
      ),
      body: Center(
        child: SizedBox(
          width: 150.0,
          child: TextField(
            maxLength: 4,
            maxLengthEnforced: true,
            style: TextStyle(
                fontSize: 24.0,
                letterSpacing: 16.0
            ),
            textAlign: TextAlign.center,
            onSubmitted: (text) => onOtpSubmit(text),
            keyboardType: TextInputType.numberWithOptions(
                signed: false, decimal: false
            ),
            decoration: InputDecoration(
              counterText: "",
              focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 2.4)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.4)),
            ),
          ),
        ),
      )
    );
  }
}