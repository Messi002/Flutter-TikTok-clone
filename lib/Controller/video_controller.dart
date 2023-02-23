import 'package:ap2/Models/video_model.dart';
import 'package:ap2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  //making it observable to bind some streams to it...
  final Rx<List<VideoModel>> _videoList = Rx<List<VideoModel>>([]);

  List<VideoModel> get videoList => _videoList.value;

  @override
  void onInit() {
    super.onInit();
//so that when a user uploads a video we get it in real time...
    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<VideoModel> retVal = [];
      for (var element in query.docs) {
        retVal.add(VideoModel.fromSnap(element));
      }
      return retVal;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user!.uid;

    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayRemove([uid])
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid])
      });
    }
  }
}



//to be able to present a static screen using a fututre without the stream method below
// Stream<List<Post>> returnStream() {
  //   var stream = Stream<List<Post>>.fromFuture(returnCaption());
  //   return stream;
  // }

  // Future<List<Post>> returnCaption() async {
  //   try {
  //     return await _firestore
  //         .collection('posts')
  //         .get()
  //         .then((QuerySnapshot query) {
  //       List<Post> retValue = [];
  //       for (var element in query.docs) {
  //         retValue.add(Post.fromJson(
  //             path: 'posts', json: element.data()! as Map<String, dynamic>));
  //       }
  //       print(retValue);
  //       retVal = retValue;
  //       return retVal;
  //     });
  //   } catch (e) {
  //     throw Exception(e.toString());
  //   }
  // }