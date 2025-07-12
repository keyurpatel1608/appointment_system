import 'package:flutter/material.dart';

enum AuthMode {
  login,
  signup,
}

class AuthForm extends StatefulWidget {
  final AuthMode authMode;
  final Function(String email, String password, String? displayName) onSubmit;
  final bool isLoading;

  const AuthForm({
    super.key,
    required this.authMode,
    required this.onSubmit,
    required this.isLoading,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String? _displayName;

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(_email, _password, _displayName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
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
                if (widget.authMode == AuthMode.signup)
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
                const SizedBox(height: 12),
                if (widget.isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _trySubmit,
                    child: Text(widget.authMode == AuthMode.login ? 'Login' : 'Sign Up'),
                  ),
                TextButton(
                  onPressed: () {
                    // This button would typically switch between login/signup modes
                    // or navigate to the other screen.
                    if (widget.authMode == AuthMode.login) {
                      Navigator.of(context).pushReplacementNamed('/signup'); // Example navigation
                    } else {
                      Navigator.of(context).pop(); // Example navigation back to login
                    }
                  },
                  child: Text(widget.authMode == AuthMode.login
                      ? 'Create new account'
                      : 'I already have an account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}