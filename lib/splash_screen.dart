import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stackx/features/auth/login_check.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash-screen';
  const SplashScreen({key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const  LoginCheck(),
          ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Image.asset(
                'images/logo.jpg',
                height: 200,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
