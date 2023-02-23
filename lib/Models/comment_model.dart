// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class CommentModel {
  String username;
  String comment;
  final datePublished;
  List likes;
  String photoUrl;
  String uid;
  String id;

  CommentModel({
    required this.datePublished,
    required this.username,
    required this.comment,
    required this.likes,
    required this.photoUrl,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'comment': comment,
      'datePublished': datePublished,
      'likes': likes,
      'photoUrl': photoUrl,
      'uid': uid,
      'id': id,
    };
  }

  static CommentModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CommentModel(
      username: snapshot['username'] as String,
      comment: snapshot['comment'] as String,
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'] as List,
      photoUrl: snapshot['photoUrl'] as String,
      uid: snapshot['uid'] as String,
      id: snapshot['id'] as String,
    );
  }
}
