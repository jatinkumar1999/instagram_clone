import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/utils/colors.dart';

import '../screens/add_post_screen.dart';
import '../screens/feedback_screen.dart';

class MobileScreenLayoutScreen extends StatefulWidget {
  final int? selectIndex;
  const MobileScreenLayoutScreen({super.key, this.selectIndex = 0});

  @override
  State<MobileScreenLayoutScreen> createState() =>
      _MobileScreenLayoutScreenState();
}

class _MobileScreenLayoutScreenState extends State<MobileScreenLayoutScreen> {
  int _page = 0;
  PageController? pageController;

  @override
  void initState() {
    super.initState();
    _page = widget.selectIndex ?? 0;
    pageController = PageController(initialPage: widget.selectIndex ?? 0);
  }

  @override
  void dispose() {
    super.dispose();
    pageController?.dispose();
  }

  void navigateToPage(int page) {
    pageController?.jumpToPage(page);
  }

  void onPageChange(int index) {
    _page = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          FeedbackScreen(),
          Text('Search'),
          AddPostScreen(),
          Text('Favourite'),
          Text('Profile'),
        ],
        controller: pageController,
        onPageChanged: onPageChange,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: mobileBackgroundColor,
        onTap: navigateToPage,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
