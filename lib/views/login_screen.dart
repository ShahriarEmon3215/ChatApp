
import 'package:chat_app/constants.dart';
import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/components/custom_button.dart';
import 'package:chat_app/views/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static String screen = 'login-screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  String _email;
  String _password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 150.0,
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
                    decoration: customTextFieldDecoration.copyWith(hintText: "Email"),
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
                    decoration: customTextFieldDecoration.copyWith(hintText: "Password"),
                    textAlign: TextAlign.center,
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  CustomButton(
                    buttonText: "Login now",
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final loginUser = await _auth.signInWithEmailAndPassword(email: this._email, password: this._password);
                      if(loginUser != null){
                        Navigator.pushReplacementNamed(context, ChatScreen.screen);
                      }
              
                      setState(() {
                        showSpinner = false;
                      });
                      } catch (e){
                        print(e);
                      }
                    },
                  ),

                  Text("Not registered yet? "),
                  TextButton(onPressed: (){
                    Navigator.pushReplacementNamed(context, RegistrationScreen.screen);
                  }, child: Text("REGISTER NOW")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
