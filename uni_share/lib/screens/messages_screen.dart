import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/screens/chat_screen.dart';
import 'package:uni_share/screens/profile_screen_2.dart';

class AllChatsScreen extends StatelessWidget {
  AllChatsScreen({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Chats',
          style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w500),
          
        ),
        centerTitle: true,
        actions: [
           InkWell(
              onTap: () {
                Get.to(ProfileScreen2(uid: auth.currentUser!.uid));
              },
              child: Icon(
                Icons.more_horiz,
                color: Colors.white,
              )),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
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
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }
          return ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildUserListItem(DocumentSnapshot doc) {
    final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

    // Check if the current user is authenticated and data contains the necessary fields
    if (auth.currentUser != null &&
        data.containsKey('email') &&
        data.containsKey('uid') &&
        data.containsKey('profilePhoto') &&
        data.containsKey('name')) {
      // Only show users that are not the current user
      if (auth.currentUser!.email != data['email']) {
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(data['profilePhoto']),
          ),
          title: Text(data['name']),
          subtitle: Text('Tap to chat', style: TextStyle(color: Colors.yellow),),
          trailing: Icon(Icons.more_vert),
          onTap: () {
            Get.to(ChatPage(
              receiverUserEmail: data['email'],
              receiverUserID: data['uid'],
              profilePhoto: data['profilePhoto'],
              userName: data['name'],
            ));
          },
        );
      }
    }

    // Return an empty container if the conditions are not met
    return Container();
  }
}
