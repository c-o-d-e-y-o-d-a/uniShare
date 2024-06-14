import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/screens/chat_screen.dart';

class AllChatsScreen extends StatelessWidget {
   AllChatsScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Chats'),
        centerTitle: true,
        actions: [
          Icon(
            Icons.add_circle_outline,
            color: Colors.red,
          )
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){

            return const Text("Error");
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),

          );
        });
  }
  
  Widget _buildUserListItem(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    // Check if the current user is authenticated and data contains the necessary fields
    if (_auth.currentUser != null &&
        data.containsKey('email') &&
        data.containsKey('uid')) {
      // Only show users that are not the current user
      if (_auth.currentUser!.email != data['email']) {
        return ListTile(
          title: Text(data['email']), // Title should be a widget like Text
          onTap: () {
            Get.to(ChatPage(
                receiverUserEmail: data['email'], receiverUserID: data['uid']));
          },
        );
      }
    }

    // Return an empty container if the conditions are not met
    return Container();
  }

}
