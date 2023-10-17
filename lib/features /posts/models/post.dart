import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? description;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String? postUrl;
  final String userImg;

  const Post({
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.userImg,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'postId': postId,
        'datePublished': datePublished,
        'postUrl': postUrl,
        'userImg': userImg,
        'decription': description,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      uid: snapshot['uid'],
      username: snapshot['username'],
      postId: snapshot['postId'],
      datePublished: snapshot['datePublished'],
      postUrl: snapshot['postUrl'],
      userImg: snapshot['userImg'],
      description: snapshot['description'],
    );
  }
}
