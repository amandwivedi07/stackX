import 'package:flutter/material.dart';
import '../features/auth/register_screen.dart';

class NotYetRegister extends StatelessWidget {
  const NotYetRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text(' Not yet Register?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, RegisterScreen.routeName);
                },
                child: const Text('Register here'),
              ),
              // const Text('&'),
              // TextButton(
              //   onPressed: () {},
              //   child: const Text('Privacy Policy'),
              // )
            ],
          )
        ],
      ),
      // Terms of Service & Privacy Policy.
    );
  }
}
