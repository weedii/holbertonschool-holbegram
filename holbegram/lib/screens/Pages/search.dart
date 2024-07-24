import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:holbegram/widgets/text_field.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    getPostsImages();
  }

  void getPostsImages() async {
    var posts = await FirebaseFirestore.instance.collection("posts").get();
    List<String> imgsArry = [];

    for (var post in posts.docs) {
      imgsArry.add(post.data()["postUrl"]);
    }
    setState(() {
      images = imgsArry;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldInput(
                  ispassword: false,
                  controller: searchController,
                  hintText: "Search",
                  keyboardType: TextInputType.text,
                ),

                const SizedBox(height: 10),

                // images
                StaggeredGrid.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: images.map((image) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 2,
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
