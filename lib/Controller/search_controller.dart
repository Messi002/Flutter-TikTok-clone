import 'package:ap2/Models/user_model.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchUsers = Rx<List<UserModel>>([]);

  List<UserModel> get searchedUsers => _searchUsers.value;

  SearchUser(String typedUser) async {
        
  }
}
