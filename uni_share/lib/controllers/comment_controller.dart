import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/comment_model.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";

  @override
  void onInit() {
    super.onInit();
    // Any other initialization
  }

  void updatePostId(String id) {
    _postId = id;
    getComment();
  }

  void getComment() {
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

  Future<int> getCommentCount(String postId) async {
    final querySnapshot = await firestore
        .collection('videos')
        .doc(postId)
        .collection('comments')
        .get();
    return querySnapshot.docs.length;
  }

  Future<void> postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        User? currentUser = firebaseAuth.currentUser;
        if (currentUser != null) {
          DocumentSnapshot userDoc =
              await firestore.collection('users').doc(currentUser.uid).get();

          if (userDoc.exists && userDoc.data() != null) {
            var userData = userDoc.data() as Map<String, dynamic>;
            var allDocs = await firestore
                .collection('videos')
                .doc(_postId)
                .collection('comments')
                .get();
            int len = allDocs.docs.length;

            Comment comment = Comment(
              username: userData['name'] ?? 'Unknown',
              comment: commentText.trim(),
              datePublished: DateTime.now(),
              likes: [],
              profilePhotos: userData['profilePhoto'] ?? '',
              uid: currentUser.uid,
              id: 'Comment $len',
            );

            await firestore
                .collection('videos')
                .doc(_postId)
                .collection('comments')
                .doc('Comment $len')
                .set(comment.toJson());

            // Fetch comments again to reflect the new comment
            getComment();
          } else {
            Get.snackbar('Error', 'User data is missing');
          }
        } else {
          Get.snackbar('Error', 'User not found');
        }
      } else {
        Get.snackbar('Error', 'Comment cannot be empty');
      }
    } catch (e) {
      Get.snackbar('Error posting comment', e.toString());
    }
  }

  Future<void> likeComment(String commentId) async {
    try {
      User? currentUser = firebaseAuth.currentUser;
      if (currentUser != null) {
        DocumentReference commentRef = firestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc(commentId);

        DocumentSnapshot commentDoc = await commentRef.get();

        if (commentDoc.exists && commentDoc.data() != null) {
          List<dynamic> likes =
              (commentDoc.data() as Map<String, dynamic>)['likes'] ?? [];

          if (likes.contains(currentUser.uid)) {
            // Unlike the comment
            commentRef.update({
              'likes': FieldValue.arrayRemove([currentUser.uid])
            });
          } else {
            // Like the comment
            commentRef.update({
              'likes': FieldValue.arrayUnion([currentUser.uid])
            });
          }

          // Fetch comments again to reflect the new like status
          getComment();
        } else {
          Get.snackbar('Error', 'Comment not found');
        }
      } else {
        Get.snackbar('Error', 'User not found');
      }
    } catch (e) {
      Get.snackbar('Error liking comment', e.toString());
    }
  }
}
