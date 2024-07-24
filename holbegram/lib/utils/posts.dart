import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:holbegram/providers/user_provider.dart";
import "package:holbegram/screens/Pages/methods/post_storage.dart";
import "package:provider/provider.dart";

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PostStorage _postStorage = PostStorage();

  void handleSavePost(postId) async {
    // get userInfo
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var userInfo = userProvider.user!;

    // update user saved posts list
    userInfo.saved.add(postId);

    // upload user changes
    CollectionReference users = FirebaseFirestore.instance.collection("users");
    await users.doc(userInfo.uid).update(userInfo.toJson());

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Post saved!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.red,
          ));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "No data!",
              style: TextStyle(fontSize: 20),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data!.docs[index].data();

              return SingleChildScrollView(
                child: Container(
                  margin: EdgeInsetsGeometry.lerp(
                      const EdgeInsets.all(8), const EdgeInsets.all(8), 10),
                  height: 540,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration:
                                    const BoxDecoration(shape: BoxShape.circle),
                                child: Image.network(data["profImage"],
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Text(data["username"]),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.more_horiz),
                              onPressed: () async {
                                await _postStorage.deletePost(data["postId"]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Post Deleted")),
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        child: Text(data["caption"]),
                      ),

                      const SizedBox(height: 10),

                      // image post
                      Container(
                        width: 350,
                        height: 350,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          image: DecorationImage(
                            image: NetworkImage(data["postUrl"]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // actions
                      Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.bookmark_outline_outlined),
                            onPressed: () {
                              handleSavePost(data["postId"]);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
