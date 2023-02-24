import 'dart:developer';

import 'package:ap2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
  }

  getUserData() async {
    List<String> thumbnails = [];

    var myVideos = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();

    for (var i = 0; i < myVideos.docs.length; i++) {
      log('${myVideos.docs[i].data()}');
      log('${myVideos.docs[i]}');
      log('${myVideos.docs}');
      thumbnails.add((myVideos.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();

    final userData = userDoc.data()! as dynamic;
    String name = userData['name'];
    String profilePhoto = userData['profilePhoto'];
    int likes = 0;
    int following = 0;
    int followers = 0;
    bool isFollowing = true;

    for (var item in myVideos.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followingDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('following')
        .get();

    var followerDoc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('follower')
        .get();

    followers = followerDoc.docs.length;
    following = followingDoc.docs.length;

    //checking whether or not the user has followers
    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authController.user?.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': followers.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnails': thumbnails,
    };

    update();
  }
}
