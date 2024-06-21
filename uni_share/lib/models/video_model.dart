import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String username;
  String uid;
  String id;
  List<String> likes;
  int commentCount;
  int shareCount;
  String title;
  String caption;
  String videoUrl;
  String thumbnail;
  String profilePhoto;

  Video({
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.title,
    required this.caption,
    required this.videoUrl,
    required this.thumbnail,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "title": title,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
        "profilePhoto": profilePhoto,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      username: snapshot['username'] ?? '',
      uid: snapshot['uid'] ?? '',
      id: snapshot['id'] ?? '',
      likes: List<String>.from(
      snapshot['likes'] ?? []), 
      commentCount: snapshot['commentCount'] ?? 0,
      shareCount: snapshot['shareCount'] ?? 0,
      title: snapshot['title'] ?? '',
      caption: snapshot['caption'] ?? '',
      videoUrl: snapshot['videoUrl'] ?? '',
      thumbnail: snapshot['thumbnail'] ?? '',
      profilePhoto: snapshot['profilePhoto'] ?? '',
    );
  }
}
