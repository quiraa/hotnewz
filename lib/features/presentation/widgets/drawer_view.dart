import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/features/presentation/pages/settings_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildDrawerHeader(context),
            buildDrawerContent(context),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Theme.of(context).colorScheme.primary,
      width: double.maxFinite,
      height: 240,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 86,
            height: 86,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'U',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Username',
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerContent(BuildContext context) {
    return Wrap(
      runSpacing: 16.0,
      children: [
        ListTile(
          leading: const Icon(CupertinoIcons.settings_solid),
          title: const Text('Settings'),
          onTap: () {
            Navigator.of(context).pop();
            PersistentNavBarNavigator.pushNewScreen(
              context,
              screen: const SettingsPage(),
              withNavBar: false,
            );
          },
        ),
      ],
    );
  }
}
