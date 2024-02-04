import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/modals/post.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../widgets/post_card.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/ic_instagram.svg',
              width: 100,
              height: 40,
              color: Colors.white,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            const Icon(Icons.keyboard_arrow_down_sharp)
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_border,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message_outlined,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: snapshot.data?.docs.length ?? 0,
              itemBuilder: (context, index) {
                var snap = snapshot.data?.docs[index];

                Post post = Post.fromSnaps(snap!.data());

                return PostCard(
                  likeDoubleonTapAnimation: () async {
                    String postId = post.postId ?? '';

                    await FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .update(
                      {
                        'likes': post.islike == true
                            ? (post.likes ?? 0) != 0
                                ? (post.likes ?? 0) - 1
                                : (post.likes ?? 0)
                            : (post.likes ?? 0) + 1,
                        'islike': post.islike == true ? false : true,
                      },
                    );
                  },
                  likeOnTap: () async {
                    String postId = post.postId ?? '';

                    await FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .update(
                      {
                        'likes': post.islike == true
                            ? (post.likes ?? 0) != 0
                                ? (post.likes ?? 0) - 1
                                : (post.likes ?? 0)
                            : (post.likes ?? 0) + 1,
                        'islike': post.islike == true ? false : true,
                      },
                    );
                  },
                  deleteOnTap: () async {
                    String postId = post.postId ?? '';
                    Navigator.pop(context);

                    await FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .delete();
                  },
                  updateOnTap: () {
                    String postId = post.postId ?? '';
                    Navigator.pop(context);

                    FirebaseFirestore.instance
                        .collection('posts')
                        .doc(postId)
                        .update(
                      {'description': 'Testing descriptions'},
                    );
                  },
                  postImages: post.postImage,
                  userImage: post.userImage,
                  userName: post.username ?? '',
                  likes: post.likes.toString(),
                  desc: post.desc,
                  postImage: post.postImage,
                  publishDate: post.postPublishedDate,
                  islike: post.islike,
                );
              });
        },
      ),
    );
  }
}
