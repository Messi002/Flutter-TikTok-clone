import 'package:ap2/Models/comment_model.dart';
import 'package:ap2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  final Rx<List<CommentModel>> _comments = Rx<List<CommentModel>>([]);
  List<CommentModel> get comments => _comments.value;

  String _postId = "";
   updatePostId(String id) {
    _postId = id;
    getComments();
  }



  getComments() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<CommentModel> retValue = [];
      for (var element in query.docs) {
        retValue.add(CommentModel.fromSnap(element));
      }
      return retValue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(authController.user!.uid)
            .get();
        var allDocs = await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();
        int len = allDocs.docs.length;
        CommentModel comment = CommentModel(
          datePublished: DateTime.now(),
          username: (userDoc.data() as Map<String, dynamic>)['name'],
          comment: commentText.trim(),
          likes: [],
          photoUrl: (userDoc.data() as Map<String, dynamic>)['photoUrl'],
          uid: authController.user!.uid,
          id: 'Comment $len',
        );

        await firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comments $len')
            .set(comment.toJson());

        DocumentSnapshot doc =
            await firestore.collection('videos').doc(_postId).get();
        await firestore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar('Error while Commenting', e.toString());
    }
  }

  //   likeComment(String id) async {
  //   DocumentSnapshot doc = await firestore.collection('videos').doc(_postId).collection('comments').doc(id).get();
  //   var uid = authController.user!.uid;

  //   if ((doc.data()! as dynamic)['likes'].contains(uid)) {
  //     await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
  //       'likes' : FieldValue.arrayRemove([uid])
  //     });
  //   }else{
  //    await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
  //       'likes' : FieldValue.arrayUnion([uid])
  //     });
  //   }
  // }



  likeComment(String id) async {
    DocumentSnapshot doc = await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();

    var uid = authController.user!.uid;

    if ((doc.data()! as dynamic)('likes').contains(uid)) {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]), 
      });
    }
  }

  deleteComment(String id) async {
  

    await firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .delete();
  }
}
