import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/providers/auth_provider.dart';
import 'package:appointment_system/core/utils/permission_utils.dart';
import 'package:appointment_system/features/calendar/screens/calendar_screen.dart';
import 'package:appointment_system/features/reports/screens/reports_screen.dart';
import 'package:appointment_system/features/settings/screens/settings_screen.dart';
import 'package:appointment_system/features/company/screens/company_profile_screen.dart';
import 'package:appointment_system/features/notifications/screens/notification_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const CalendarScreen(),
    const ReportsScreen(),
    const NotificationScreen(),
    const SettingsScreen(),
    const CompanyProfileScreen(), // Example of adding a new screen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final currentUserRole = authProvider.currentUser?.role;

    // Define navigation items based on user role
    final List<BottomNavigationBarItem> _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        label: 'Calendar',
      ),
      if (currentUserRole != null && PermissionUtils.canViewScreen(currentUserRole, Screen.reports)) 
        const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Reports',
        ),
      if (currentUserRole != null && PermissionUtils.canViewScreen(currentUserRole, Screen.notifications)) 
        const BottomNavigationBarItem(
          icon: Icon(Icons.notifications),
          label: 'Notifications',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      if (currentUserRole != null && PermissionUtils.canViewScreen(currentUserRole, Screen.companyProfile)) 
        const BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Company',
        ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _navItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
      ),
    );
  }
}