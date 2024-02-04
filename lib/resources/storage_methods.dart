import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      {String? childName, Uint8List? file, bool? isPost = false}) async {
    Reference ref =
        storage.ref().child(childName!).child(auth.currentUser!.uid);
    if (isPost == true) {
      String id = Uuid().v1();
      ref = ref.child(id);
    }
    //upload image

    UploadTask uploadTask = ref.putData(file!);
    TaskSnapshot snap = await uploadTask;

    String downloadImageUrl = await snap.ref.getDownloadURL();

    return downloadImageUrl;
  }
}
