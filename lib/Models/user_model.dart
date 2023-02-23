import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String name;
  String photoUrl;
  String email;
  String uid;
  
  UserModel({
    required this.name,
    required this.photoUrl,
    required this.email,
    required this.uid,
  });
  


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'photoUrl': photoUrl,
      'email': email,
      'uid': uid,
    };
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      name: snapshot['name'] as String,
      photoUrl: snapshot['photoUrl'] as String,
      email: snapshot['email'] as String,
      uid: snapshot['uid'] as String,
    );
  }


}
