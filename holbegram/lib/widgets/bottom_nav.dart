import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:holbegram/screens/Pages/add_image.dart';
import 'package:holbegram/screens/Pages/favorite.dart';
import 'package:holbegram/screens/Pages/feed.dart';
import 'package:holbegram/screens/Pages/profile_screen.dart';
import 'package:holbegram/screens/Pages/search.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          Feed(),
          Search(),
          AddImage(),
          Favorite(),
          Profile(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        showElevation: true,
        itemCornerRadius: 8,
        curve: Curves.easeInBack,
        onItemSelected: (index) => {
          setState(() {
            _currentIndex = index;
          }),
          _pageController.jumpToPage(index)
        },
        items: [
          BottomNavyBarItem(
            icon: const Icon(Icons.home_outlined),
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.search_outlined),
            title: const Text(
              "Search",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.add),
            title: const Text(
              "Add",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.favorite_outline),
            title: const Text(
              "Favorite",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
          BottomNavyBarItem(
            icon: const Icon(Icons.person_outline),
            title: const Text(
              "Profile",
              style: TextStyle(fontSize: 25, fontFamily: "Billabong"),
            ),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
            inactiveColor: Colors.black,
          ),
        ],
      ),
    );
  }
}
