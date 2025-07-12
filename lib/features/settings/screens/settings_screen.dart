import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Profile Settings'),
            subtitle: const Text('Manage your personal information'),
            leading: const Icon(Icons.person),
            onTap: () {
              // Navigate to profile settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile settings not implemented yet.')),
              );
            },
          ),
          ListTile(
            title: const Text('Notification Settings'),
            subtitle: const Text('Configure notification preferences'),
            leading: const Icon(Icons.notifications),
            onTap: () {
              // Navigate to notification settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification settings not implemented yet.')),
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Settings'),
            subtitle: const Text('Adjust your privacy controls'),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              // Navigate to privacy settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings not implemented yet.')),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              await authProvider.logout();
              if (!context.mounted) return;
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}