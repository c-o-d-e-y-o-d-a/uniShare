import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);

  List<User> get searchedUsers => _searchedUsers.value;

  void searchUser(String typedUser) {
    _searchedUsers.bindStream(
      FirebaseFirestore.instance
          .collection('users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map((QuerySnapshot query) {
        List<User> retVal = [];
        query.docs.forEach((doc) {
          retVal.add(User.fromSnap(doc));
        });
        return retVal;
      }),
    );
  }

  @override
  void onClose() {
    // Clean up stream subscription when the controller is closed
    _searchedUsers.close();
    super.onClose();
  }
}
