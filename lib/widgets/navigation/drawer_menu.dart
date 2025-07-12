import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final String userName;
  final String userEmail;
  final List<Widget> menuItems;

  const DrawerMenu({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(userName),
            accountEmail: Text(userEmail),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.blueAccent),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ...menuItems,
        ],
      ),
    );
  }
}