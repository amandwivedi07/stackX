import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackx/constant/bottom_bar.dart';

import '../../constant/global_variable.dart';
import '../../constant/utils.dart';
import '../../main.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/not_yet_register.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final _signInFormKey = GlobalKey<FormState>();

class _LoginScreenState extends State<LoginScreen> {
  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passwordController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login '),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: GlobalVariables.backgroundColor,
        child: Form(
          key: _signInFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              CustomTextField(hintText: 'Email', controller: _emailController),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                  hintText: 'Password', controller: _passwordController),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                  text: 'Sign In',
                  onTap: () {
                    if (_signInFormKey.currentState!.validate()) {
                      signIN();
                    }
                  })
            ],
          ),
        ),
      ),
      bottomSheet: const NotYetRegister(),
    );
  }

  Future signIN() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) => {
            
            
                Navigator.pushNamedAndRemoveUntil(
                    context, BottomBar.routeName, (route) => false)
              });
              setState(() {
               _signInFormKey .currentState!.reset();
               _emailController.clear();
               _passwordController.clear();
              });
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
      // print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
