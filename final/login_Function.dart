import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'login_signup.dart';

class LoginFunction extends StatefulWidget {
  const LoginFunction({super.key});

  @override
  State<LoginFunction> createState() => _LoginFunctionState();
}

class _LoginFunctionState extends State<LoginFunction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const Homescreen();
              } else {
                return const LoginSignup();
              }
            }));
  }
}
