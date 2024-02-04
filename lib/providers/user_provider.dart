import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  User? _user;
  String? userName, userImage;

  User? get user => _user;
  //Get current user detail
  Future<void> getUserDetails() async {
    DocumentSnapshot sh =
        await db.collection('users').doc(auth.currentUser!.uid!).get();
    var map = sh.data() as Map<String, dynamic>;
    log('user name==>>>${map['userName']}');
    log('user image==>>>${map['image']}');
    userName = map['userName'];
    userImage = map['image'];
    notifyListeners();
  }
}
