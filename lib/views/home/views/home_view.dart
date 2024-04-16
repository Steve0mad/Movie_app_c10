import 'package:flutter/material.dart';
import 'package:movies/views/browse/browse_view_body.dart';
import 'package:movies/views/home/views/widgets/home_view_body.dart';
import 'package:movies/views/search/views/seartch_view_body.dart';
import 'package:movies/views/wishlist/wishlist_view_body.dart';

class HomeView extends StatefulWidget {
  static const String routeName = 'HomeView';
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> tabs = [
    const HomeViewBody(),
    SearchViewBody(),
    const BrowseViewBody(),
    const WishListViewBody(),
  ];

  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab,
        onTap: (value) {
          selectedTab = value;
          setState(() {});
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w300,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.house),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'BROWSE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'WISHLIST',
          ),
        ],
      ),
      body: SafeArea(child: tabs[selectedTab]),
    );
  }
}
