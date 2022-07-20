import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../constant/global_variable.dart';

class ProjectDone extends StatefulWidget {
  String? empId;
  ProjectDone({this.empId, Key? key}) : super(key: key);

  @override
  State<ProjectDone> createState() => _ProjectDoneState();
}

class _ProjectDoneState extends State<ProjectDone> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .5,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: const Text(
                'Project Done',
                style: TextStyle(color: Colors.white),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('EmployeeID')
                    .doc(widget.empId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                    if (snapshot.data!['projectDone'].length==0) {
                    return const Center(
                      child: Text('No yet completed any project')
                    );
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!['projectDone'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        GlobalVariables.divider;
                        return ListTile(
                          title: Text(
                            'Project Name: \n${snapshot.data!['projectDone'][index]['projectName']}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          subtitle: Text(
                            'Time Period: ${snapshot.data!['projectDone'][index]['timePeriod']}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        );
                      });
                } //

                ),
          ],
        ),
      ),
    );
  }
}
