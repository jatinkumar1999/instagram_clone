import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/modals/post.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:intl/intl.dart';

import 'like_animation.dart';

class PostCard extends StatefulWidget {
  final String? userImage;
  final String? userName;
  final String? postImages;
  final String? likes;
  final String? desc;
  final String? postImage;
  final String? publishDate;
  final bool? islike;
  final VoidCallback? likeOnTap;
  final VoidCallback? updateOnTap;
  final VoidCallback? deleteOnTap;
  final VoidCallback? likeDoubleonTapAnimation;
  const PostCard({
    super.key,
    this.userImage,
    this.userName,
    this.postImages,
    this.likes,
    this.islike = false,
    this.desc,
    this.postImage,
    this.publishDate,
    this.likeOnTap,
    this.updateOnTap,
    this.deleteOnTap,
    this.likeDoubleonTapAnimation,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    log('s post isn liked=>>>${widget.islike}');
    return Container(
      color: mobileBackgroundColor,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          //!Post top Design
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10)
                .copyWith(right: 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(widget.userImage ??
                      'https://images.unsplash.com/photo-1682688759157-57988e10ffa8?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fHx8'),
                ),
                const SizedBox(width: 10),
                Text(
                  widget.userName ?? 'Jatin Kumar',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return SimpleDialog(
                              children: [
                                SimpleDialogOption(
                                  onPressed: widget.updateOnTap,
                                  child: const Text(
                                    'Edit',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const Divider(),
                                SimpleDialogOption(
                                  onPressed: widget.deleteOnTap,
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.more_vert,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          //!Post Images
          GestureDetector(
            onDoubleTap: widget.likeDoubleonTapAnimation,
            child: Stack(
              children: [
                SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Image.network(
                      widget.postImage ??
                          'https://images.unsplash.com/photo-1706474178699-7e3db9b2ba92?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzfHx8ZW58MHx8fHx8',
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.3,
                      fit: BoxFit.cover,
                    )),
                Visibility(
                  visible: widget.islike ?? false,
                  child: Positioned(
                      top: MediaQuery.of(context).size.height * 0.08,
                      left: 0,
                      right: 0,
                      child: const LikeAnimation()),
                ),
              ],
            ),
          ),
          //!Post status List

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                onPressed: widget.likeOnTap,
                icon: Icon(
                  widget.islike == true
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.islike == true ? Colors.red : Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mode_comment_outlined,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 5,
            ),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 2,
                  text: TextSpan(
                    text: widget.userName ?? 'Jatin Kumar',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                    children: [
                      TextSpan(
                        text: widget.desc != null
                            ? ' ${widget.desc}'
                            : ' This is the first description is for testng the instagram clone description design',
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '${widget.likes ?? 0} likes',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'View all 4 comments',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  DateFormat()
                      .add_MMMMd()
                      .format(DateTime.parse(widget.publishDate ?? "")),
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.white.withOpacity(0.4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
