import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';

class AuthController extends GetxController{
  //upload to firebase storage
  Future<String> _uploadToStorage (File image) async {
    try{
      Reference ref  = firebaseStorage
      .ref()
      .child('profilePics')
      .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
    }
    catch(e){
      throw Exception('dfdsf');
    
  }




  //registering the user

  void registerUser(String username, String email, String password, File? image) async {
    try{
      if(username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && image != null){

        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password);

         String downloadUrl = await _uploadToStorage(image);

        

      }

    }
    catch(e){
      Get.snackbar(
        'Error creating account',
         e.toString());

    }
  }




} 
}