import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackx/features/home/widget/internship_detail_container.dart';
import '../../services/emp_services.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    EmpServices _empServices = EmpServices();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('EmployeeID')
            .doc(empid)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: Text("Document does not exist",style: TextStyle(fontSize: 16),));
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return InternshipDetailContainer(document: snapshot.data);
          }
          return const CircularProgressIndicator();
        },
      ),

      // FutureBuilder<DocumentSnapshot>(
      //   future: _empServices.empdata.doc(empData!['employeId']).get(),
      //   builder:
      //       (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //     if (snapshot.hasError) {
      //       return const Text("Something went wrong");
      //     }
      //     if (!snapshot.hasData) {
      //       return const Center(
      //         child: CircularProgressIndicator(
      //           color: GlobalVariables.mainThemeColor,
      //         ),
      //       );
      //     }

      //     if (!snapshot.data!.exists) {
      //       return const Center(child: Text("Document does not exist"));
      //     }

      //     Map<String, dynamic> data =
      //         snapshot.data!.data() as Map<String, dynamic>;
      //     // return HomeScreenDesgin(document: snapshot.data);
      //     return InternshipDetailContainer(document: snapshot.data);
      //   },
      // ),
      // persistentFooterButtons: [
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
}
