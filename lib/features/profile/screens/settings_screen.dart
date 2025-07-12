import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Profile Settings'),
            subtitle: const Text('Update your personal information'),
            onTap: () {
              // Navigate to profile settings
            },
          ),
          ListTile(
            title: const Text('Notification Settings'),
            subtitle: const Text('Manage your notification preferences'),
            onTap: () {
              // Navigate to notification settings
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            subtitle: const Text('Adjust your privacy controls'),
            onTap: () {
              // Navigate to privacy settings
            },
          ),
          ListTile(
            title: const Text('About Us'),
            subtitle: const Text('Learn more about the application'),
            onTap: () {
              // Navigate to about us screen
            },
          ),
          ListTile(
            title: const Text('Logout'),
            subtitle: const Text('Sign out from your account'),
            onTap: () {
              // Implement logout logic
            },
          ),
        ],
      ),
    );
  }
}