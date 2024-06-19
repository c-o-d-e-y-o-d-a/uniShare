import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/video_model.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
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

      Get.back(); // Assuming Get is used for navigation
    } catch (e) {
      print('Error uploading video: $e');
      Get.snackbar("Error uploading video", e.toString());
    }
  }

  Future<File?> _compressVideo(String videoPath) async {
    try {
      final compressedVideo = await VideoCompress.compressVideo(videoPath,
          quality: VideoQuality.MediumQuality);
      if (compressedVideo != null) {
        print('Video compressed successfully');
        return compressedVideo.file;
      } else {
        print('Video compression failed');
        return null;
      }
    } catch (e) {
      print('Error during video compression: $e');
      return null;
    }
  }

  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    try {
      print('Video upload function started');

      // Compress the video
      File? compressedVideo = await _compressVideo(videoPath);
      if (compressedVideo == null) {
        throw Exception("Video compression failed");
      }

      // Reference to Firebase Storage
      Reference ref = firebaseStorage.ref().child('videos').child(id);
      print('Video upload reference found');

      // Upload the file with metadata
      UploadTask uploadTask = ref.putFile(
        compressedVideo,
        SettableMetadata(
          cacheControl: 'public,max-age=3600',
          contentType: 'video/mp4',
        ),
      );
      print('Compressed file found');

      // Await the upload task
      TaskSnapshot snap = await uploadTask;
      print('Download URL found');
      String downloadUrl = await snap.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading video to storage: $e');
      rethrow; // Preserve original exception and stack trace
    }
  }

  Future<File?> _getThumbnail(String videoPath) async {
    try {
      final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
      if (thumbnail != null) {
        print('Thumbnail found');
        return thumbnail;
      } else {
        print('Thumbnail generation failed');
        return null;
      }
    } catch (e) {
      print('Error generating thumbnail: $e');
      return null;
    }
  }

  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    try {
      print('Upload image to storage function starts');
      File? thumbnail = await _getThumbnail(videoPath);
      if (thumbnail == null) {
        throw Exception("Thumbnail generation failed");
      }

      // Reference to Firebase Storage
      Reference ref = firebaseStorage.ref().child('thumbnails').child(id);
      print('Upload image to storage reference found');

      // Upload the file with metadata
      UploadTask uploadTask = ref.putFile(
        thumbnail,
        SettableMetadata(
          cacheControl: 'public,max-age=3600',
          contentType: 'image/jpeg',
        ),
      );
      print('File has been uploaded');

      // Await the upload task
      TaskSnapshot snap = await uploadTask;
      String downloadUrl = await snap.ref.getDownloadURL();
      Get.snackbar("Vide uploaded", "Your video has beenn uploaded successfully!");

      return downloadUrl;
    } catch (e) {
      print('Error uploading image to storage: $e');
      rethrow; // Preserve original exception and stack trace
    }
  }
}
