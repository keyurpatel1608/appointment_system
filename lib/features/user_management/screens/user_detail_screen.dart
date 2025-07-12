import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/user_provider.dart';
import 'package:appointment_system/core/models/user_model.dart';
import 'package:appointment_system/routes/app_router.dart';

class UserDetailScreen extends StatefulWidget {
  final String userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  User? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserDetail();
  }

  Future<void> _fetchUserDetail() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = await userProvider.getUserById(widget.userId);
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load user details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        actions: [
          if (_user != null)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                AppRouter.router.go('${AppRouter.editUserRoute}/${widget.userId}');
              },
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _user == null
              ? const Center(child: Text('User not found.'))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Display Name: ${_user!.displayName ?? 'N/A'}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Email: ${_user!.email}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Role: ${_user!.role}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Company ID: ${_user!.companyId ?? 'N/A'}',
                          style: const TextStyle(fontSize: 18)),
                      const SizedBox(height: 8),
                      Text('Status: ${_user!.status}',
                          style: const TextStyle(fontSize: 18)),
                      // Add more user details as needed
                    ],
                  ),
                ),
    );
  }
}