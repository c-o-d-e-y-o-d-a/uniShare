import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  List likes;
  String profilePhotos;
  String uid;
  String id;

  Comment(
      {required this.username,
      required this.comment,
      required this.datePublished,
      required this.likes,
      required this.profilePhotos,
      required this.uid,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "comment": comment,
      "dataPublished": datePublished,
      "likes": likes,
      "profilePhotos": profilePhotos,
      "uid": uid,
      "id": id
    };
  }

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
        username: snapshot['username'],
        comment: snapshot['comment'],
        datePublished: snapshot['comment'],
        profilePhotos: snapshot['profilePhotos'],
        likes: snapshot['likes'],
        uid: snapshot['uid'],
        id: snapshot['id']);
  }
}
