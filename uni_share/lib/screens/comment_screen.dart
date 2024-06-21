import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/controllers/comment_controller.dart';
import 'package:uni_share/models/comment_model.dart';

class CommentScreen extends StatelessWidget {
  final String postId;
  final CommentController commentController = Get.put(CommentController());

  CommentScreen({required this.postId});

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(postId);

    TextEditingController commentControllerText = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Comments',
          style: TextStyle(color: Colors.yellow),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  Comment comment = commentController.comments[index];
                  bool isLiked =
                      comment.likes.contains(firebaseAuth.currentUser?.uid);
                  int likeCount = comment.likes.length;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(comment.profilePhotos),
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          comment.username,
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                commentController.likeComment(comment.id);
                              },
                            ),
                            Text(
                              '$likeCount',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    subtitle: Text(comment.comment),
                  );
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentControllerText,
                    decoration: InputDecoration(
                        hintText: 'Add a comment...',
                        hintStyle: TextStyle(color: Colors.yellow)),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.yellow,
                  ),
                  onPressed: () {
                    commentController.postComment(commentControllerText.text);
                    commentControllerText.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
