// ignore_for_file: prefer_const_constructors
import 'package:ffriendlychat/Screens/homePage.dart';
import 'package:ffriendlychat/Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user Loged in --->>
          if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(snapshot.error.toString())));
          }
          if (snapshot.hasData) {
            return homePage();
          } else {
            return loginScreen();
          }
        },
      ),
    );
  }
}
