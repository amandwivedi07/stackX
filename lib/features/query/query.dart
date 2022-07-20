import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:stackx/widgets/custom_text_field.dart';

class Query extends StatefulWidget {
  
  Query({Key? key}) : super(key: key);

  @override
  State<Query> createState() => _QueryState();


}
String username = "query@stackxsolutions.in";

class _QueryState extends State<Query> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Qurery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: CustomTextField(
                controller: _messageController,
                hintText: 'Query?',
                maxLines: 6,
              )),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: () {
                    // queryEmail('diligentdwivedi@gmail.com', _messageController.text);
                    queryMessage('diligentdwivedi@gmail.com');
                  },
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
    password: "QWERASDF@1234",
    allowInsecure: true);

void queryMessage(email) async {
  // Create our message.
  final message = Message()
    ..from = Address(username, "StackX")
    ..recipients.add(email)
    ..subject = 'Your order is placed with id '
    ..text =
        "We are happy to inform you that we have recieved your order with Order-ID .\nYour data is sent to the canteen, you can take away your food using the QR code provided in the app.\nThankyou for using our app and do let us know about the app on App Store.\nHave a good meal.";

  try {
    print('attempting to send email');
    final sendReport = await send(message, smtpServer);

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
