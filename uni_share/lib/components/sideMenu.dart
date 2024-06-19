import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/controllers/auth_controller.dart';
import 'package:uni_share/screens/about_us_screen.dart';
import 'package:uni_share/screens/add_video_screen.dart';
import 'package:uni_share/screens/messages_screen.dart';
import 'package:uni_share/screens/profile_screen_2.dart';

class MySideMenu extends StatelessWidget {
  const MySideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nischal'),
            accountEmail: const Text('123@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.yellow,
              
              child: ClipOval(
                child: Image.asset('assets/logo.png'),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.yellow,),
            title: const Text('Profile',
              style: TextStyle(color: Colors.yellow),
            ),
            onTap: () {
              Get.to(ProfileScreen2(
                uid: authController.user!.uid,
              ));
            },
          ),
          ListTile(
            leading: Icon(Icons.upload, color: Colors.yellow),
            title: const Text('Upload Video',
              style: TextStyle(color: Colors.yellow),
            ),
            onTap: () {
              Get.to(AddVideoScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.description, color: Colors.yellow),
            title: const Text('About us',
              style: TextStyle(color: Colors.yellow),
            ),
            onTap: () {
              Get.to(AboutUsScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.message, color: Colors.yellow),
            title: const Text('Messages',
              style: TextStyle(color: Colors.yellow),
            ),
            onTap: () {
              Get.to(AllChatsScreen());
            },
          ),
          ListTile(
            leading: Icon(Icons.catching_pokemon, color: Colors.yellow,),
            title: const Text('View on GitHub', style: TextStyle(color: Colors.yellow),),
            onTap: () {
              Get.snackbar('Page not found',
                  'Hey There! This page is currently in development');
            },
          ),
          SizedBox(height: 20,),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.yellow),
            title: const Text('Settings',style: TextStyle(color: Colors.yellow),),
            onTap: () {
              Get.snackbar('Page not found',
                  'Hey There! This page is currently in development');
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.yellow),
            title: const Text('Sign Out',
              style: TextStyle(color: Colors.yellow),
            ),
            onTap: () {
              authController.signOut();
            },
          ),
        ],
      ),
    );
  }
}
