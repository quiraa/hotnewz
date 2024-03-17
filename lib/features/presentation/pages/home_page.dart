import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/presentation/pages/news/discover_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/favorite_page.dart';
import 'package:flutter_news_app/features/presentation/pages/news/news_page.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(context),
      confineInSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.background,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: false,
      decoration: NavBarDecoration(borderRadius: BorderRadius.circular(0)),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
      navBarHeight: 64,
    );
  }
}

List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.news_solid),
      inactiveIcon: const Icon(CupertinoIcons.news),
      title: ("News"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.compass_fill),
      inactiveIcon: const Icon(CupertinoIcons.compass),
      title: ("Discover"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.bookmark_solid),
      inactiveIcon: const Icon(CupertinoIcons.bookmark),
      title: ("Favorite"),
      activeColorPrimary: Theme.of(context).colorScheme.primary,
      inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
    ),
  ];
}

List<Widget> _buildScreens() {
  return [
    const NewsPage(),
    DiscoverPage(),
    const FavoritePage(),
  ];
}
