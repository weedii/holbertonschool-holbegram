import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userInfo;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  void getUserInfo() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    var user = userProvider.user!;
    setState(() {
      userInfo = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              "Holbegram",
              style: TextStyle(
                fontFamily: "Billabong",
                fontSize: 35.0,
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 50.0,
              width: 50.0,
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () async {
              AuthMethode authMethods = AuthMethode();
              await authMethods.signOut();
              Navigator.pushReplacementNamed(context, "/login");
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
          ),
        ],
      ),

      // body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 110,
                  height: 110,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userInfo.photoUrl),
                  ),
                ),

                //
                const SizedBox(width: 20),

                Column(
                  children: [
                    Text(
                      "${userInfo.posts.length}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "posts",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                Column(
                  children: [
                    Text(
                      "${userInfo.followers.length}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "followers",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  ],
                ),

                const SizedBox(width: 20),

                Column(
                  children: [
                    Text(
                      "${userInfo.following.length}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "following",
                      style: TextStyle(fontSize: 18, color: Colors.black38),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 10),

            // username
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Text(userInfo.username,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 50),

            // users posts
            Wrap(
              spacing: 8, // Space between images horizontally
              runSpacing: 8,
              children: userInfo.posts.map<Widget>((image) {
                return Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: 115,
                  height: 120,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
