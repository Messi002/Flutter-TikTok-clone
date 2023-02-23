import 'package:ap2/Controller/auth_controller.dart';
import 'package:ap2/View/screens/addvideo_screen.dart';
import 'package:ap2/View/screens/search_screen.dart';
import 'package:ap2/View/screens/vide_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

///[pages] to navigate to the different screens
List<Widget> pages =  [
  VideoScreen(),
  const SearchScreen(),
  const AddVideoScreen(),
  const Text('message screen'),
  const Text('profile screen'),
];

//COLORS
const kBackgroundColor = Colors.black;
var kButtonColor = Colors.red[400];
const kBorderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS
var authController = AuthController.instance;
