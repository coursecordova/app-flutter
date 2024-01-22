import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Membuat koneksi dengan database
FirebaseFirestore db = FirebaseFirestore.instance;

// get course data for user from database
Stream<Map<String, dynamic>> getCourseByEmail(String email) {
  CollectionReference users = db.collection('users');

  return users
      .where('email', isEqualTo: email)
      .snapshots()
      .map((QuerySnapshot query) {
    if (query.docs.isNotEmpty) {
      Map<String, dynamic> data = query.docs.first['course'];
      return data;
    } else {
      return {};
    }
  });
}
