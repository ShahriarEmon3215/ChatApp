import 'package:chat_app/views/chat_screen.dart';
import 'package:chat_app/views/login_screen.dart';
import 'package:chat_app/views/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: ChatScreen(),
      initialRoute: WelcomeScreen.screen,
      routes: {
        WelcomeScreen.screen: (context) => WelcomeScreen(),
        ChatScreen.screen: (context) => ChatScreen(),
        LoginScreen.screen: (context) => LoginScreen(),
        RegistrationScreen.screen: (context) => RegistrationScreen(),
      },
    );
  }
}
