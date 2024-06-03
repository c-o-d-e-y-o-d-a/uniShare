import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/comment_model.dart';
import 'package:uni_share/controllers/auth_controller.dart';
import 'package:uni_share/models/user_model.dart';

import '../models/user_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(firestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comment> retValue = [];
      for (var element in query.docs) {
        retValue.add(Comment.fromSnap(element));
      }
      return retValue;
    }));
  }

  // postComment(String commentText) async {
  //   try {
  //     if (commentText.isNotEmpty) {
  //       auth.User? currentUser = Get.find<AuthController>().user;
  //       if (currentUser != null) {
  //         DocumentSnapshot userDoc =
  //             await firestore.collection('users').doc(currentUser.uid).get();
  //         var allDocs = await firestore
  //             .collection('videos')
  //             .doc(_postId)
  //             .collection('comments')
  //             .get();
  //         int len = allDocs.docs.length;

         

  //         await firestore
  //             .collection('videos')
  //             .doc(_postId)
  //             .collection('comments')
  //             .doc('Comment $len')
  //             .set(comments.toJson());

  //         // Fetch comments again to reflect the new comment
  //         getComment();
  //       } else {
  //         Get.snackbar('Error', 'User not found');
  //       }
  //     } else {
  //       Get.snackbar('Error', 'Comment cannot be empty');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error posting comment', e.toString());
  //   }
  // }
}
