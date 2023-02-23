import 'package:ap2/Models/video_model.dart';
import 'package:ap2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  //to compress video using a package called video_compress
  _compressVideo(videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressedVideo!.file;
  }

//precise function to upload video to firestorage and returning downloadUrl
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    ///to create the folder in the database
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    UploadTask uploadTask = ref.putFile(await _compressVideo(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  ///function for generating [_uploadImageToStorage for thumbnail] for images... and uploading it to firestorage...
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    ///to create the folder in the database for thumbnails
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    UploadTask uploadTask = ref.putFile(await _getThumbnail(videoPath));
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);

    return thumbnail;
  }

  //function to upload video and also thumbnails...
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      //get id
      var allDocs = await firestore.collection('videos').get();
      int len = allDocs.docs.length;
      //video for storage
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      //function for thumbnail
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      VideoModel videoModel = VideoModel(
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: 'Video $len',
          likes: [],
          commentCount: 0,
          shareCount: 0,
          songName: songName,
          videoUrl: videoUrl,
          caption: caption,
          thumbnail: thumbnail,
          //this is to query the database and get the photoUrl using the userDoc.data()!
          profilePhoto: (userDoc.data()! as Map<String, dynamic>)['photoUrl']);

      //saving now to firestore not firebase_storage
      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(videoModel.toJson());
      //taking us back to the add video screen

      Get.back();
    } catch (e) {
      Get.snackbar('Error Uploading Video', e.toString());
    }
  }
}
