import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stackx/constant/global_variable.dart';
import 'package:stackx/features/home/widget/connect_with_us.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constant/reusable_container.dart';

class InternshipDetailContainer extends StatefulWidget {
  final DocumentSnapshot? document;
  InternshipDetailContainer({this.document, Key? key}) : super(key: key);

  @override
  State<InternshipDetailContainer> createState() =>
      _InternshipDetailContainerState();
}

class _InternshipDetailContainerState extends State<InternshipDetailContainer> {
  @override
  Widget build(BuildContext context) {
    const controllerTo = 'info@stackxsolutions.in';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Column(children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Name : ${widget.document!['name']}',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    'Internship Start : ${widget.document!['internshipStart']}',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    'Internship End : ${widget.document!['internshipEnd']}',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Text(
                    'Stipened: ${widget.document!['stipened'].toString()}',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ]),
              ),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.16,
            ),
          ),
        ),
        const SizedBox(height: 20,),
        ReusableContainer(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text('Current Project',
                      style: TextStyle(
                          color: GlobalVariables.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.document!['currentProject'],
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Time Period : ${widget.document!['timePeriod']}',
                    style: const TextStyle(color: Colors.white, fontSize: 17),
                  ),

                  //TO Do time Period
                ],
              ),
            )),
        const SizedBox(
          height: 40,
        ),
        const Divider(
          color: Colors.grey,
          height: 2,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        ListTile(
          // tileColor: Theme.of(context)
          //     .primaryColor
          //     .withOpacity(.3),
          leading: const Icon(Icons.contact_phone_outlined),
          title: const Text(
            'Contact Us',
            style: TextStyle(fontSize: 18),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () async {
                  const phoneNumber = '+917018036347';
                  const url = 'tel:$phoneNumber';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: Icon(Icons.phone_in_talk, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  launchEmail(toEmail: controllerTo);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(4)),
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 8.0, right: 8, top: 2, bottom: 2),
                    child: const Icon(Icons.email, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

        ),
       const  SizedBox(height: 5,),
           const Divider(
          color: Colors.grey,
          height: 2,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
        const SizedBox(
          height: 20,
        ),
        const ConnectWithUs()
      ],
    );
  }

  Future launchEmail({required String toEmail}) async {
    final url = 'mailto:$toEmail';

    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
