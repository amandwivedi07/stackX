import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmpServices {
  CollectionReference empdata =
      FirebaseFirestore.instance.collection('EmployeeID');
}
