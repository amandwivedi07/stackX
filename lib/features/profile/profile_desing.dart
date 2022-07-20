import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stackx/constant/global_variable.dart';
import 'package:stackx/constant/reusable_container.dart';
import 'package:stackx/features/profile/widget/project_done_dialog.dart';

import '../auth/login_screen.dart';
import 'widget/account_container.dart';

class ProfileDesign extends StatefulWidget {
  final DocumentSnapshot? document;
  ProfileDesign({this.document, Key? key}) : super(key: key);

  @override
  State<ProfileDesign> createState() => _ProfileDesignState();
}

class _ProfileDesignState extends State<ProfileDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SearchContainer(
                    icon: CupertinoIcons.money_dollar_circle,
                    containerText: 'Paid Stipened',
                    containerHeadText: '₹ ${widget.document!['paidStipened']}',
                  ),
                  SearchContainer(
                    icon: CupertinoIcons.money_dollar_circle,
                    containerText: 'Unpaid Stipened',
                    containerHeadText:
                        '₹ ${widget.document!['unpaidStipened']}',
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SearchContainer(
                    icon: CupertinoIcons.money_dollar_circle,
                    containerText: 'Incentive',
                    containerHeadText: '₹ ${widget.document!['incentivePaid']}',
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ProjectDone(
                              empId: widget.document!['empId'],
                            );
                          });
                    },
                    child: SearchContainer(
                      icon: Icons.done,
                      containerText: 'Project Done',
                      containerHeadText:
                          widget.document!['projectDone'].length.toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  openDialog();
                },
                child: ReusableContainer(
                  height: 100,
                  width: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.download,
                              color: Colors.white,
                              size: 30,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          'Download Certificates',
                          style: TextStyle(
                              fontSize: 16,
                              color: GlobalVariables.textColor,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              )
            ],
          )),
        ),
      ),
      //    persistentFooterButtons: [
      //   Row(
      //     children: [
      //       Expanded(
      //           child: ElevatedButton(
      //         onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
      //             Navigator.pushNamedAndRemoveUntil(
      //                 context, LoginScreen.routeName, (route) => false)),
      //         child: const Text('Log Out'),
      //       )),
      //     ],
      //   ),
      // ],
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: const Text('Download Cetificate'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  openFile(
                      url: widget.document!['internshipofferLetter'],
                      fileName: '${widget.document!['name']} InternshipLetter');
                },
                child: const Text(
                  'Internship Letter',
                  style: TextStyle(color: GlobalVariables.mainThemeColor),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  openFile(
                      url: 'http://www.africau.edu/images/default/sample.pdf',
                      fileName: 'InternshipCompetition.pdf');
                },
                child: const Text('Intenrship Completion Letter',
                    style: TextStyle(color: GlobalVariables.mainThemeColor)),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close',
                    style: TextStyle(color: GlobalVariables.mainThemeColor)),
              ),
            ],
          ));

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    print('Path :${file.path}');

    OpenFile.open(file.path);
  }

//Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
