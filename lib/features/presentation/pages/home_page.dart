import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/presentation/pages/news/discover_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/favorite_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screenOptions[_selectedIndex],
      bottomNavigationBar: _buildNavbar(),
    );
  }

  Widget _buildNavbar() {
    return NavigationBar(
      selectedIndex: _selectedIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.feed),
          icon: Icon(Icons.feed_outlined),
          label: 'News',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.explore_rounded),
          icon: Icon(Icons.explore_outlined),
          label: 'Discover',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.bookmarks_rounded),
          icon: Icon(Icons.bookmarks_outlined),
          label: 'Bookmark',
        ),
      ],
      onDestinationSelected: _onItemTapped,
    );
  }

  static const _screenOptions = <Widget>[
    NewsPage(),
    DiscoverPage(),
    FavoritePage(),
  ];
}
