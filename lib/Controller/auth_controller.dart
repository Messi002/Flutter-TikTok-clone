import 'dart:io';
import 'package:ap2/Models/user_model.dart' as model;
import 'package:ap2/View/screens/auth/login_screen.dart';
import 'package:ap2/View/screens/home_screen.dart';
import 'package:ap2/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
//returning to us an instance of the authcontroller
  static AuthController instance = Get.find();

//making observable the user model from firebase to know whether we can
//automaticatlly login the user or not
  late Rx<User?> _user;
  User? get user => _user.value;

//onready just like oninit being called on the _user to know whether it is null or not

  @override
  void onReady() {
    super.onReady();
    //to know whether user is signed in
    _user = Rx<User?>(firebaseAuth.currentUser);
    //listen to changes from sign-in state
    _user.bindStream(firebaseAuth.authStateChanges());
    //if user is signed in then move to the home screen, not wanting to use getpages
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

//used for keeping track of the image which acts like a stream
  late Rx<File?> _pickedImage;

//getter function
  File? get profilePhoto => _pickedImage.value;

//for selecting an image
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar('Profile Picture', 'Successfully loaded...');
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  //upload to firebase_storage for pics
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  ///[Registering the user]
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //save user credentials to firebase
        UserCredential userCred =
            await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //getting the downloadUrl from firebase_Storage...
        String downloadUrl = await _uploadToStorage(image);
        //using the created model to parse the object to json to send to our database
        model.UserModel user = model.UserModel(
            email: email,
            name: username,
            uid: userCred.user!.uid,
            photoUrl: downloadUrl);
        //saving the data to firestore database where users are stored
        await firestore
            .collection('users')
            .doc(userCred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
            "Error creating account", 'Please Fill in all the fields...');
      }
    } catch (e) {
      Get.snackbar("Error creating account", e.toString());
    }
  }

  ///[loginUser] section
  void loginUser(String email, String password) {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        print('error');
      } else {
        Get.snackbar("Error logging in", 'Please Fill in all the fields...');
      }
    } catch (e) {
      Get.snackbar("Error logging in", e.toString());
    }
  }
}
