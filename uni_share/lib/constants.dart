import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uni_share/controllers/auth_controller.dart';
import 'package:uni_share/screens/add_video_screen.dart';
import 'package:uni_share/screens/search_screen.dart';
import 'package:uni_share/screens/video_screen.dart';

//screens to refer to
List pages = [
  VideoScreen(),

  SearchScreen(),

  const AddVideoScreen(),

  const Text("homescreen"),

  const Text("homescreen"),


];

//theme colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;




//firebase related constants
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;




//CONTROLLERS
var authController = AuthController.instance;