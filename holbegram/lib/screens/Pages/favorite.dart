import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<String> savedImages = [];

  @override
  void initState() {
    super.initState();
    getSavedPosts();
  }

  void getSavedPosts() async {
    List<String> imgsArry = [];

    // get userInfo
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var userInfo = userProvider.user!;

    var posts = await FirebaseFirestore.instance.collection("posts").get();

    for (var post in posts.docs) {
      if (userInfo.saved.contains(post.data()["postId"])) {
        imgsArry.add(post.data()["postUrl"]);
      }
    }

    setState(() {
      savedImages = imgsArry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),

                //
                const Text(
                  "Saved Images",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 20),
                Column(
                  children: savedImages.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Image.network(image, fit: BoxFit.cover),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
