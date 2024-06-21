import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uni_share/constants.dart';
import 'package:uni_share/models/video_model.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videoList = Rx<List<Video>>([]);
  final Rx<List<Video>> _userVideoList = Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;
  List<Video> get userVideoList => _userVideoList.value;

  @override
  void onInit() {
    super.onInit();
    _userVideoList.bindStream(
      firestore.collection('videos').snapshots().map((QuerySnapshot query) {
        List<Video> retVal1 = [];
        for (var element in query.docs) {
          if (Video.fromSnap(element).uid == authController.user!.uid) {
            retVal1.add(Video.fromSnap(element));
          }
        }
        return retVal1;
      }),
    );

    _videoList.bindStream(
        firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      List<Video> retVal = [];
      for (var element in query.docs) {
        retVal.add(Video.fromSnap(element));
      }
      return retVal;
    }));
  }

  void likeVideo(String id) async {
    DocumentSnapshot doc = await firestore.collection('videos').doc(id).get();
    var uid = authController.user?.uid;
    if ((doc.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection("videos").doc(id).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(id).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
