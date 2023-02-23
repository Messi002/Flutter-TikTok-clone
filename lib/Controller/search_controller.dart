import 'package:ap2/Models/user_model.dart';
import 'package:ap2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchUsers.value;

dynamic  searchUserFunc(String typedUser) async {
    _searchUsers.bindStream(
      firestore
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<UserModel> retVal = [];
          for (var snap in query.docs) {
            retVal.add(UserModel.fromSnap(snap));
          }
          return retVal;
        },
      ),
    );
  }
}
