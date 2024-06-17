import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/video_model.dart';
import 'package:video_compress/video_compress.dart';
import 'dart:io';

class UploadVideoController extends GetxController {
  Future<File?> _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    print('Video compressed successfully');
    return compressedVideo?.file;
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    print('Video upload function started');
    File? compressedVideo = await _compressVideo(videoPath);
    if (compressedVideo == null) {
      throw Exception("Video compression failed");
    }
    Reference ref = firebaseStorage.ref().child('videos').child(id);
    print('Video upload reference found');
    UploadTask uploadTask = ref.putFile(compressedVideo);
    print('Compressed file found');
    TaskSnapshot snap = await uploadTask;
    print('Download URL found');
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File?> _getThumbnail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    print('Thumbnail found');
    return thumbnail;
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    print('Upload image to storage function starts');
    File? thumbnail = await _getThumbnail(videoPath);
    if (thumbnail == null) {
      throw Exception("Thumbnail generation failed");
    }
    Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
    print('Upload image to storage reference found');
    UploadTask uploadTask = ref.putFile(thumbnail);
    print('File has been uploaded');
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> uploadVideo(
      String title, String caption, String videoPath) async {
    print('Main upload video function starts before try');
    try {
      print('Main upload video function starts');
      String uid = firebaseAuth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        throw Exception("User document does not exist");
      }

      var allDocs = await firestore.collection('videos').get();
      print('Reference found');
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
      print('Video uploaded to storage');
      String thumbnail = await _uploadImageToStorage("Video $len", videoPath);

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      Video video = Video(
        username: userData['name'],
        uid: uid,
        id: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        title: title,
        caption: caption,
        videoUrl: videoUrl,
        thumbnail: thumbnail,
        profilePhoto: userData['profilePhoto'],
      );

      await firestore
          .collection('videos')
          .doc('Video $len')
          .set(video.toJson());
      print(
          'EVERYTHING IS DONE NOW LESGOO !!!!!!!!!!!!!!! Video object uploaded to Firestore');

      Get.back();
    } catch (e) {
      Get.snackbar("Error uploading video", e.toString());
    }
  }
}
