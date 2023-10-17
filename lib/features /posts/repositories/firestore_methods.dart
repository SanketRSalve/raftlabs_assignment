import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:raftlabs_newsfeed/features%20/imagepick/storage/storage_methods.dart';
import 'package:raftlabs_newsfeed/features%20/posts/models/post.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    Uint8List? file,
    String? description,
    String uid,
    String username,
    String userImg,
  ) async {
    String res = "Error";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file!, true);

      String postId = const Uuid().v1();
      Post post = Post(
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postUrl: photoUrl,
        userImg: userImg,
        description: description,
      );
      _firestore.collection('posts').doc(postId).set(post.toJson());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
