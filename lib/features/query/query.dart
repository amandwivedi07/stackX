import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:stackx/widgets/custom_text_field.dart';

import '../../main.dart';

class Query extends StatefulWidget {
  Query({Key? key}) : super(key: key);

  @override
  State<Query> createState() => _QueryState();
}

String username = "query@stackxsolutions.in";

class _QueryState extends State<Query> {
  User? user = FirebaseAuth.instance.currentUser;
  var empData;
  var empid;

  @override
  void initState() {
    getEmployeID();
    super.initState();
  }

  Future<DocumentSnapshot> getEmployeID() async {
    var result = await FirebaseFirestore.instance
        .collection('employees')
        .doc(user!.uid)
        .get();
    setState(() {
      empData = result;
      empid = empData!['employeId'];
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Query'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: CustomTextField(
                controller: _messageController,
                hintText:
                    'Any Query?,please feel free to share with us, We will revert back as soon as possible',
                maxLines: 6,
              )),
              SizedBox(
                height: 80,
              ),
              // TextButton(onPressed: (){
              //   print(empid);
              // },
              //  child: Text('EmpId')),
              ElevatedButton(
                  onPressed: () {
                    if (_messageController.text.isEmpty) {
                      Fluttertoast.showToast(msg: 'Your message is empty');
                    } else {
                      queryMessage('info@stackxsolutions.in',
                          _messageController.text, empid);
                           FocusScope.of(context).unfocus();
                      // queryMessage('amanshalabh@gmail.com');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                  ),
                  child: Text('Send'))
            ],
          ),
        ),
      ),
    );
  }

  final smtpServer = SmtpServer("stackxsolutions.in",
      ignoreBadCertificate: true,
      username: username,
      password: "QWERT@123",
      allowInsecure: true);

  void queryMessage(email, queryMessage, empid) async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    // Create our message.
    final message = Message()
      ..from = Address(username, "StackX")
      // ..recipients.add("diligentdwivedi@gmail.com")
      ..recipients.add(email)
      ..subject = 'Query of EmpId ${empid}'
      ..text = queryMessage;

    try {
      final sendReport = await send(message, smtpServer).then((value) => {
            Fluttertoast.showToast(
                msg: 'Your query has been successfully submitted')
          });
      setState(() {
        queryMessage == null;
      });
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
     
      // Navigator.pop(context);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print(e);
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
