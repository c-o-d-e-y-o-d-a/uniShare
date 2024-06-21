import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/components/message_text_input_feild.dart';
import 'package:uni_share/controllers/chat_controller.dart';
import 'package:intl/intl.dart'; // For formatting timestamps

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  final String profilePhoto;
  final String userName;

  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID,
      required this.profilePhoto,
      required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatController _chatService = ChatController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 35,
        leading: InkWell(
          onTap: (){Get.back();},
          child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: Icon(Icons.arrow_back),
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profilePhoto),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(widget.userName),
              ],
            )),
        actions: [
          InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(19),
                child: Icon(Icons.more_vert),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.yellow)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  fillColor: Color.fromARGB(255, 18, 18, 18),
                  filled: true,
                  hintText: 'Send Message',
                  hintStyle: const TextStyle(
                    color: Colors.yellow,
                  )),
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(
              Icons.arrow_upward,
              color: Colors.yellow,
              size: 30,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var containerColor = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Colors.yellow[200]
        : Colors.yellow[600];

    return Container(
      alignment: alignment,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(
        crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment:
                  (data['senderId'] == _firebaseAuth.currentUser!.uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                Text(
                  data['message'],
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat('h:mm a').format(data['timestamp'].toDate()),
                  style: TextStyle(
                      fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }
}
