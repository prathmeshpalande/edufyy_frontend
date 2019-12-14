import 'dart:math';

import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  onOtpSubmit(String otp) {
    //TODO: implement this
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter OTP"),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              OTPFields(
                onSubmit: (text) => onOtpSubmit(text),
              )
            ]
        ),
      ),
    );
  }
}

class OTPFields extends StatefulWidget {
  final onSubmit;

  OTPFields({
    this.onSubmit,
  });

  @override
  State createState() {
    return OTPFieldsState();
  }
}

class OTPFieldsState extends State<OTPFields> {
  @override
  void initState() {
    super.initState();
    digits = new List<String>(4);

    int i = 0;
    digitsController = new List(4);
    focusNodes = new List(4);
    while(i < 4) {
      digitsController[i] = new TextEditingController();
      focusNodes[i] = new FocusNode();
    }

  }
  var digits;
  var digitsController;
  var focusNodes;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  onDigitChange(int i) {
    digits[i] = digitsController[i].text;
    if (i == 4) {
      focusNodes[i].unfocus();
      onSubmit();
    } else {
      _fieldFocusChange(context, focusNodes[i], focusNodes[i + 1]);
    }
  }

  generateOneField(int i) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        controller: digitsController[i],
        focusNode: focusNodes[i],
        maxLength: 1,
        style: TextStyle(
          fontSize: 24.0
        ),
        textAlign: TextAlign.center,
        onSubmitted: onDigitChange(i),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Theme.of(context).accentColor, width: 2.0)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor, width: 2.0)),
        ),
      ),
    );
  }

  generateFields() {
    List<Widget> fields = new List<Widget>(4);
    int i = 0;
    while (i < 4) fields[i] = generateOneField(i++);
    return fields;
  }

  onSubmit() {
    return digits.join;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: generateFields()
    );
  }
}