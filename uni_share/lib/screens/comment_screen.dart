import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String postId;
  CommentScreen({super.key, required this.postId});

  final TextEditingController _commentController = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(postId);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (commentController.comments.isEmpty) {
                return Center(
                    child: Text('No comments yet',
                        style: TextStyle(color: Colors.white)));
              }
              return ListView.builder(
                itemCount: commentController.comments.length,
                itemBuilder: (context, index) {
                  final comment = commentController.comments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(comment.profilePhotos),
                    ),
                    title: Row(
                      children: [
                        Text(
                          comment.username,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: 8), // Add some spacing
                        Expanded(
                          child: Text(
                            comment.comment, // Display the comment text
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis, // Prevent overflow
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          tago.format(comment.datePublished.toDate()),
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${comment.likes.length} likes',
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        )
                      ],
                    ),
                    trailing: InkWell(
                      onTap: () {
                        // Add your like functionality here
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              );
            }),
          ),
          const Divider(),
          ListTile(
            title: TextFormField(
              controller: _commentController,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                labelText: 'Comment',
                labelStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
            ),
            trailing: TextButton(
              onPressed: () {
                commentController.postComment(_commentController.text);
                _commentController.clear();
              },
              child: const Text(
                'Send',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
