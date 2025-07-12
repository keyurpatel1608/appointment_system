import 'package:flutter/material.dart';

class NavItem {
  final String title;
  final IconData icon;
  final String route;
  final List<String> requiredRoles; // Roles that can see this item

  const NavItem({
    required this.title,
    required this.icon,
    required this.route,
    this.requiredRoles = const [],
  });
}