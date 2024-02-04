import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? desc;
  String? userImage;

  String? id;
  String? username;
  int? likes;
  bool? islike;
  bool isNotlike = false;
  String? postId;
  String? postImage;
  String? postPublishedDate;

  Post({
    this.desc,
    this.likes,
    this.id,
    this.postId,
    this.postImage,
    this.postPublishedDate,
    this.userImage,
    this.username,
    this.islike,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userImage': userImage,
      'description': desc,
      'username': username,
      'likes': likes,
      'islike': islike,
      'postId': postId,
      'postImage': postImage,
      'postPublishedDate': postPublishedDate,
    };
  }

  Post.fromSnap(DocumentSnapshot sp) {
    Map<String, dynamic> data = sp.data() as Map<String, dynamic>;

    id = data['id'];
    userImage = data['userImage'];
    username = data['username'];
    desc = data['description'];
    likes = data['likes'];
    islike = data['islike'];
    postId = data['postId'];
    postImage = data['postImage'];
    postPublishedDate = data['postPublishedDate'];
  }
  Post.fromSnaps(Map<String, dynamic> sp) {
    Map<String, dynamic> data = sp;
    log('likes==>>>${data['likes']}');
    id = data['id'];
    userImage = data['userImage'];
    username = data['username'];
    desc = data['description'];
    likes = data['likes'] ?? 0;
    islike = data['islike'] ?? false;
    postId = data['postId'];
    postImage = data['postImage'];
    postPublishedDate = data['postPublishedDate'];
  }
}
