import 'dart:ui';

import 'package:flutter/material.dart';

import '../registration_screen.dart';

class CustomButton extends StatelessWidget {
  String buttonText;
  VoidCallback onPressed;

  CustomButton({
    this.buttonText,
    @required this.onPressed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),

        // padding: MaterialStateProperty.all(const EdgeInsets.all(50))),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
