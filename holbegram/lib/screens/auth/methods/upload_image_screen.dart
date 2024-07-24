import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  const AddPicture(
      {super.key,
      required this.email,
      required this.password,
      required this.username});

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;
  final AuthMethode authMethode = AuthMethode();

  Future selectImageFromGallery() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img != null) {
        setState(() {
          _image = File(img.path).readAsBytesSync();
        });
      }
    } catch (e) {
      print('Error picking image from gallery: $e');
    }
  }

  Future selectImageFromCamera() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img != null) {
        setState(() {
          _image = File(img.path).readAsBytesSync();
        });
      }
    } catch (e) {
      print('Error picking image from camera: $e');
    }
  }

  void handleSignup() async {
    var res = await authMethode.signUpUser(
      email: widget.email,
      password: widget.password,
      username: widget.username,
    );

    if (res == "success") {
      Navigator.pushNamed(context, "/login");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Holbegram",
                      style: TextStyle(fontFamily: "Billabong", fontSize: 50),
                    ),

                    // logo
                    Image.asset(
                      "assets/images/logo.png",
                      width: 80,
                      height: 60,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // welcome
              const Text(
                "Hello, Jhon Doe Welcome to \nHolbegram",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text(
                "Choose an image from your gallery or take a new one.",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              Center(
                child: _image != null
                    ? CircleAvatar(
                        radius: 100,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : Image.asset(
                        "assets/images/user_icon.png",
                        width: 200,
                        height: 200,
                      ),
              ),

              const SizedBox(height: 20),

              // pick image
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // gallery
                  GestureDetector(
                    onTap: () {
                      selectImageFromGallery();
                    },
                    child: const Icon(
                      Icons.image_outlined,
                      size: 60,
                      color: Colors.red,
                    ),
                  ),

                  const SizedBox(width: 130),

                  // camera
                  GestureDetector(
                    onTap: () {
                      selectImageFromCamera();
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 63,
                      color: Colors.red,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 40),

              // next button
              Center(
                child: GestureDetector(
                  onTap: () {
                    handleSignup();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
