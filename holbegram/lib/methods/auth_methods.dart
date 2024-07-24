import "dart:typed_data";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:holbegram/models/user.dart";
import "package:holbegram/providers/user_provider.dart";

class AuthMethode {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    Uint8List? file,
  }) async {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      return "Please fill all the fields";
    }

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? userInfo = userCredential.user;

      Users newUser = Users(
        uid: userInfo!.uid,
        email: email,
        username: username,
        bio: "",
        photoUrl:
            "https://firebasestorage.googleapis.com/v0/b/holbegram-258c0.appspot.com/o/th.jfif?alt=media&token=0112a519-4ac2-487a-80a0-4a7c5d616477",
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: "",
      );

      await _firestore
          .collection("users")
          .doc(userInfo.uid)
          .set(newUser.toJson());
      return "success";
    } catch (e) {
      return e.toString();
    }
  }

  Future getUserDetails(res) async {
    var userDoc = await FirebaseFirestore.instance
        .collection("users")
        .doc(res.user?.uid)
        .get();
    return userDoc;
  }

  // sign-out
  Future<void> signOut() async {
    UserProvider userProvider = UserProvider();
    userProvider.clearUser();
    return await _auth.signOut();
  }
}
