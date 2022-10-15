import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {

 static String screen = 'register-screen';  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (value) {
                  _email = value;
                },
                decoration: customTextFieldDecoration.copyWith(hintText: 'Email'),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (value) {
                  _password = value;
                },
                decoration: customTextFieldDecoration.copyWith(hintText: 'Password'),
                textAlign: TextAlign.center,
                obscureText: true,
              ),
              SizedBox(
                height: 24.0,
              ),
              CustomButton(buttonText: "Register now", onPressed: () async {
                setState(() {
                  showSpinner = true;
                });
                try{
                  final _newUser = await  _auth.createUserWithEmailAndPassword(email: this._email, password: this._password);
                  if(_newUser != null){
                    Navigator.pushReplacementNamed(context, ChatScreen.screen);
                  }

                  setState(() {
                    showSpinner = false;
                  });
                } catch (e){
                  print(e);
                }
              
              },),
            ],
          ),
        ),
      ),
    );
  }
}
