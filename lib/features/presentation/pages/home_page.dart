import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/presentation/pages/news/discover_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/favorite_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/news_page.dart';
import 'package:ionicons/ionicons.dart';

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
          selectedIcon: Icon(Ionicons.newspaper),
          icon: Icon(Ionicons.newspaper_outline),
          label: 'News',
        ),
        NavigationDestination(
          selectedIcon: Icon(Ionicons.compass),
          icon: Icon(Ionicons.compass_outline),
          label: 'Discover',
        ),
        NavigationDestination(
          selectedIcon: Icon(Ionicons.bookmarks),
          icon: Icon(Ionicons.bookmarks_outline),
          label: 'Bookmark',
        ),
      ],
      onDestinationSelected: _onItemTapped,
    );
  }

  static final _screenOptions = <Widget>[
    const NewsPage(),
    DiscoverPage(),
    const FavoritePage(),
  ];
}
