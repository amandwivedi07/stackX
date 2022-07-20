import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackx/constant/bottom_bar.dart';

import '../../constant/global_variable.dart';
import '../../constant/utils.dart';
import '../../main.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register-screen';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _empIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    scaffoldMessage(message) {
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Register '),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: GlobalVariables.backgroundColor,
        child: Form(
          key: _signUpFormKey,
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              CustomTextField(hintText: 'Emp Id', controller: _empIdController),
              const SizedBox(
                height: 10,
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
                  text: 'Sign Up',
                  onTap: () {
                    if (_signUpFormKey.currentState!.validate()) {
                      signUp();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    User? currentUser;
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((auth) {
            currentUser = auth.user;
          })
          .then((value) => saveDataToFirestore(currentUser!))
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false));
    } on FirebaseAuthException catch (e) {
      // print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future saveDataToFirestore(User currentUser) async {
    FirebaseFirestore.instance
        .collection('employees')
        .doc(currentUser.uid)
        .set({
      'uid': currentUser.uid,
      'email': currentUser.email,
      'employeId': _empIdController.text //keep initial value as false
    });
  }
}
