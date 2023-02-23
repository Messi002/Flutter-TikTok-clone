// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:cloud_firestore/cloud_firestore.dart';

class VideoModel {
  String username;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String songName;
  String videoUrl;
  String caption;
  String thumbnail;
  String profilePhoto;


  VideoModel({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.songName,
    required this.videoUrl,
    required this.caption,
    required this.thumbnail,
    required this.profilePhoto,
  });


  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'username': username,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentCount': commentCount,
      'shareCount': shareCount,
      'songName': songName,
      'videoUrl': videoUrl,
      'caption': caption,
      'thumbnail': thumbnail,
      'profilePhoto': profilePhoto,
    };
  }

  static VideoModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return VideoModel(
      username: snapshot['username'] as String,
      uid: snapshot['uid'] as String,
      id: snapshot['id'] as String,
      commentCount: snapshot['commentCount'] as int,
      shareCount: snapshot['shareCount'] as int,
      songName: snapshot['songName'] as String,
      videoUrl: snapshot['videoUrl'] as String,
      caption: snapshot['caption'] as String,
      thumbnail: snapshot['thumbnail'] as String,
      profilePhoto: snapshot['profilePhoto'] as String,
       likes: snapshot['likes'] as List,
    );
  }







}
