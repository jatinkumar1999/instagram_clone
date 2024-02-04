import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'storage_methods.dart';

class AuthMethods {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  //sign up
  Future<String> signupUser({
    required String userName,
    required String pass,
    required String email,
    required String bio,
    required Uint8List image,
  }) async {
    String res = "Some error Occured";

    try {
      //register User

      UserCredential cred = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      String urlImage = await StorageMethods().uploadImageToStorage(
        childName: 'profile_pics',
        file: image,
      );
      // add user to the database
      await fireStore.collection('users').doc(cred.user!.uid).set({
        'id': cred.user!.uid,
        'userName': userName,
        'email': email,
        'password': pass,
        'bio': bio,
        'image': urlImage,
        'followers': [],
        'following': [],
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String pass,
  }) async {
    String res = "Some error Occured";

    try {
      //register User

      UserCredential cred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
