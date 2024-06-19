import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  final Rx<String> _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    try {
      List<String> thumbnails = [];
      var myVideos = await firestore
          .collection('videos')
          .where('uid', isEqualTo: _uid.value)
          .get();

      for (var doc in myVideos.docs) {
        var thumbnail = (doc.data() as dynamic)['thumbnails'];
        if (thumbnail != null) {
          thumbnails.add(thumbnail);
        }
      }

      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(_uid.value).get();
      final userData = userDoc.data()! as dynamic;

      String name = userData['name'] ?? 'No Name';
      String profilePhoto = userData['profilePhoto'] ?? '';
      String username = userData['username'] ?? 'No Username';
      int likes = 0;
      int followers = 0;
      int following = 0;
      bool isFollowing = false;

      for (var item in myVideos.docs) {
        var likesList = item.data()['likes'] as List?;
        if (likesList != null) {
          likes += likesList.length;
        }
      }

      var followerDoc = await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .get();
      followers = followerDoc.docs.length;

      var followingDoc = await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('following')
          .get();
      following = followingDoc.docs.length;

      var currentUserFollowerDoc = await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user?.uid)
          .get();
      isFollowing = currentUserFollowerDoc.exists;

      _user.value = {
        'name': name,
        'username': username,
        'profilePhoto': profilePhoto,
        'followers': followers,
        'following': following,
        'isFollowing': isFollowing,
        'likes': likes,
        'thumbnails': thumbnails,
        'posts': userData['posts'] ?? 0 // Provide a default value of 0 if null
      };
      update();
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  followUser() async {
    try {
      var doc = await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authController.user?.uid)
          .get();
      if (!doc.exists) {
        await firestore
            .collection('users')
            .doc(_uid.value)
            .collection('followers')
            .doc(authController.user?.uid)
            .set({});
        await firestore
            .collection('users')
            .doc(authController.user?.uid)
            .collection('following')
            .doc(_uid.value)
            .set({});

        _user.value['followers']++;
      } else {
        await firestore
            .collection('users')
            .doc(_uid.value)
            .collection('followers')
            .doc(authController.user?.uid)
            .delete();
        await firestore
            .collection('users')
            .doc(authController.user?.uid)
            .collection('following')
            .doc(_uid.value)
            .delete();

        _user.value['followers']--;
      }
      _user.value['isFollowing'] = !_user.value['isFollowing'];
      update();
    } catch (e) {
      print('Error following/unfollowing user: $e');
    }
  }
}
