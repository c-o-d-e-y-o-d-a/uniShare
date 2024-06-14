import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/controllers/auth_controller.dart';
import 'package:uni_share/screens/auth/signUp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value){
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Uni Share',
      theme: ThemeData.dark().copyWith(
       
      scaffoldBackgroundColor: backgroundColor,
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/logo.png',
        splashIconSize: 2000.0,
        centered: true,
        nextScreen: SignUpScreen(),
        backgroundColor: Colors.yellow.shade300,
        duration: 8100,
      ),
       
      
    );
  }
}

