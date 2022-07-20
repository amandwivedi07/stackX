import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackx/constant/bottom_bar.dart';
import 'login_screen.dart';

class LoginCheck extends StatelessWidget {
  static const String routeName = '/login-screen';
  const LoginCheck({key}) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginScreen();
          }

          return const BottomBar();
        });
  }
}

