import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:instagram_clone/resources/fiestore_methods.dart';
import 'package:instagram_clone/utils/snack_bar.dart';
import 'package:provider/provider.dart';

import '../responsive/mobile_screen_layout_screen.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? selctedImage;
  TextEditingController descController = TextEditingController();
  bool isloading = false;

  Future<void> postImage({
    required String id,
    required String name,
    required String userImage,
    required Uint8List postImage,
  }) async {
    try {
      isloading = true;
      setState(() {});
      final res = await FireStoreMethods().uploadPost(
        id: id,
        userName: name,
        userImage: userImage,
        postImage: postImage,
        desc: descController.text,
      );

      isloading = false;
      setState(() {});
      if (res == 'success') {
        showSnackBar(context: context, content: 'post uploaded!');
        selctedImage = null;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MobileScreenLayoutScreen(),
          ),
        );

        setState(() {});
      }
    } catch (e) {}
  }

  Future<void> _selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a post'),
            children: [
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  await imagePicker(ImageSource.camera);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.pop(context);
                  await imagePicker(ImageSource.gallery);
                },
              ),
              SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () async {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  Future<void> imagePicker(ImageSource source) async {
    XFile? image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    selctedImage = kIsWeb
        ? await image.readAsBytes()
        : await File(image.path).readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return selctedImage == null
        ? Center(
            child: IconButton(
              onPressed: () {
                _selectImage(context);
              },
              icon: const Icon(Icons.upload),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              title: const Text(
                'Post to',
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () async {
                    log('user name==>>>${provider.userName}');
                    log('user image==>>>${provider.userImage}');
                    await postImage(
                      id: provider.auth.currentUser!.uid,
                      name: provider.userName ?? '',
                      userImage: provider.userImage ?? '',
                      postImage: selctedImage!,
                    );
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isloading ? const LinearProgressIndicator() : const SizedBox(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.linear,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isloading == true
                          ? const SizedBox(height: 10)
                          : const SizedBox(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(provider.userImage ?? ""),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: TextFormField(
                                controller: descController,
                                decoration: const InputDecoration(
                                  hintText: 'Write a caption ...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(
                                height: 45,
                                width: 45,
                                child: AspectRatio(
                                  aspectRatio: 487 / 451,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: MemoryImage(selctedImage!),
                                        fit: BoxFit.fill,
                                        alignment: FractionalOffset.topCenter,
                                      ),
                                    ),
                                  ),
                                )),
                          ]),
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
          );
  }
}
