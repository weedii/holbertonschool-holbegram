import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:holbegram/models/user.dart';
import 'package:holbegram/providers/user_provider.dart';
import 'package:holbegram/screens/Pages/methods/post_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:text_area/text_area.dart';

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  Uint8List? selectedImage;
  File? selectedImageToUpload;
  late Users userInfo;
  final captionController = TextEditingController();

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  void loadPreferences() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userInfo = userProvider.user!;
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.grey[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.15,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pickImageFromGallery();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image_outlined,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text("Gallery",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pickImageFromCamera();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              size: 70,
                              color: Colors.red,
                            ),
                            Text("Camera",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path).readAsBytesSync();
      selectedImageToUpload = File(returnImage.path);
    });
    Navigator.pop(context);
  }

  Future pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path).readAsBytesSync();
      selectedImageToUpload = File(returnImage.path);
    });
    Navigator.pop(context);
  }

  Future<void> handleUploadPost() async {
    PostStorage _postStorage = PostStorage();

    String res = await _postStorage.uploadPost(
      captionController.text.isEmpty ? "" : captionController.text,
      userInfo.uid,
      userInfo.username,
      userInfo.photoUrl,
      selectedImageToUpload,
      userInfo,
    );

    if (res == "Ok") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Post created!")),
      );
      Navigator.pushNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Image"),
          actions: [
            GestureDetector(
              onTap: () {
                if (selectedImage != null) {
                  handleUploadPost();
                }
              },
              child: const Text(
                "Post",
                style: TextStyle(
                  fontFamily: "Billabong",
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text(
                      "Add Image",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Choose an image from your gallery or take a one.",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // text area
              GestureDetector(
                onTap: () {
                  _focusNode.unfocus();
                },
                child: TextField(
                  focusNode: _focusNode,
                  controller: captionController,
                  minLines: 1,
                  maxLines: 100,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Write a caption...",
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  showImagePickerOption(context);
                },
                child: selectedImage != null
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.memory(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(50),
                        child: Image.asset("assets/images/add_image.png"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
