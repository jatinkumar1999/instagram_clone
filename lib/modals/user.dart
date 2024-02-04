import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String? id;
  String? image;
  List<dynamic>? followers;
  List<dynamic>? following;
  String? name;
  String? bio;
  String? email;

  User({
    this.bio,
    this.email,
    this.followers,
    this.following,
    this.id,
    this.image,
    this.name,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'followers': followers,
      'following': following,
      'name': name,
      'bio': bio,
      'email': email,
    };
  }

  User toSnap(DocumentSnapshot sp) {
    Map<String, dynamic> data = sp.data() as Map<String, dynamic>;

    return User(
      id: data['id'],
      image: data['image'],
      name: data['name'],
      bio: data['bio'],
      followers: data['followers'],
      following: data['following'],
    );
  }
}
