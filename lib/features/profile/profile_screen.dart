import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stackx/features/home/widget/internship_detail_container.dart';
import 'package:stackx/features/profile/profile_desing.dart';
import '../../services/emp_services.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile-screen';

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        actions: [
          IconButton( onPressed: () => FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, LoginScreen.routeName, (route) => false)),

         icon: Icon(Icons.exit_to_app))
        ],
        centerTitle: true,
        title: const Text('Account'),
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
            return const Center(
                child: Text(
              "Document does not exist",
              style: TextStyle(fontSize: 16),
            ));
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasData) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return ProfileDesign(document: snapshot.data);
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
