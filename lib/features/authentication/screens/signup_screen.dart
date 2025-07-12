import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/auth_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _displayName = '';

  void _trySignup() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // In a real app, you would call an authentication service to sign up
      // For this example, we'll just show a success message.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup functionality not implemented yet.')),
      );
      // Example of how you might integrate with AuthProvider if it had signup
      // try {
      //   await Provider.of<AuthProvider>(context, listen: false)
      //       .signup(_email, _password, _displayName);
      //   if (!mounted) return;
      //   Navigator.of(context).pushReplacementNamed('/dashboard');
      // } catch (e) {
      //   if (!mounted) return;
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text(e.toString())),
      //   );
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: const ValueKey('email'),
                  decoration: const InputDecoration(labelText: 'Email Address'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  key: const ValueKey('displayName'),
                  decoration: const InputDecoration(labelText: 'Display Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a display name.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _displayName = value!;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Password must be at least 6 characters long.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 20),
                if (authProvider.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _trySignup,
                    child: const Text('Sign Up'),
                  ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to login
                  },
                  child: const Text('Already have an account? Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}