import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:holbegram/models/posts.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/screens/auth/methods/user_storage.dart';
import 'package:uuid/uuid.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> uploadPost(String caption, String uid, String username,
      String profImage, File? image, Users userInfo) async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      var uuid = Uuid();
      var postID = uuid.v1();

      var downloadUrl = await _storageMethods.uploadImageToStorage(image!);

      Post posts = Post(
        caption: caption,
        uid: uid,
        username: username,
        likes: [],
        postId: postID,
        datePublished: DateTime.now(),
        postUrl: downloadUrl,
        profImage: profImage,
      );

      // upload post to firebase DB
      await _firestore.collection("posts").doc(postID).set(posts.toJson());

      // update users posts
      userInfo.posts.add(downloadUrl);
      CollectionReference users =
          FirebaseFirestore.instance.collection("users");
      await users.doc(userInfo.uid).update(userInfo.toJson());

      return "Ok";
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection("posts").doc(postId).delete();
  }
}
