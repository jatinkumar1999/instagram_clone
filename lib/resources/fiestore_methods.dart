import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../modals/post.dart';

class FireStoreMethods {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  //uplaod USer Posts
  Future<String> uploadPost({
    required String id,
    required String userName,
    required String userImage,
    required Uint8List postImage,
    required String desc,
  }) async {
    String res = 'Some Error Occured!';

    try {
      String postUrl = await StorageMethods().uploadImageToStorage(
        childName: 'posts',
        file: postImage,
        isPost: true,
      );
      String postId = Uuid().v1();

      Post post = Post(
        desc: desc,
        id: id,
        userImage: userImage,
        username: userName,
        postId: postId,
        postImage: postUrl,
        likes: 0,
        islike: false,
        postPublishedDate: DateTime.now().toString(),
      );

      log('post to Json===>>>${post.toJson()}');
      firestore.collection('posts').doc(postId).set(post.toJson());

      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
