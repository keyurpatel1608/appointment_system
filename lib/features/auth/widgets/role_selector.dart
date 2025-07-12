import 'package:flutter/material.dart';

class RoleSelector extends StatefulWidget {
  final List<String> roles;
  final Function(String?) onRoleSelected;
  final String? initialRole;

  const RoleSelector({
    super.key,
    required this.roles,
    required this.onRoleSelected,
    this.initialRole,
  });

  @override
  State<RoleSelector> createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      decoration: const InputDecoration(
        labelText: 'Select Role',
        border: OutlineInputBorder(),
      ),
      items: widget.roles.map((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          _selectedRole = newValue;
        });
        widget.onRoleSelected(newValue);
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a role';
        }
        return null;
      },
    );
  }
}