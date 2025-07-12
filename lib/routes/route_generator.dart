import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/appointment/screens/appointment_list_screen.dart';
import '../features/appointment/screens/appointment_detail_screen.dart';
import '../features/appointment/screens/appointment_form_screen.dart';
import '../features/user_management/screens/user_list_screen.dart';
import '../features/user_management/screens/user_detail_screen.dart';
import '../features/user_management/screens/user_form_screen.dart';
import '../features/role_management/screens/role_list_screen.dart';
import '../features/role_management/screens/role_form_screen.dart';
import '../features/company/screens/company_profile_screen.dart';
import '../features/notifications/screens/notification_list_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/availability_management/screens/availability_settings_screen.dart';
import '../features/availability_management/screens/slot_form_screen.dart';
import '../features/onboarding/screens/onboarding_screen.dart';

class RouteGenerator {
  static const String onboardingRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String dashboardRoute = '/dashboard';
  static const String appointmentListRoute = '/appointments';
  static const String appointmentDetailRoute = '/appointments/detail';
  static const String appointmentFormRoute = '/appointments/form';
  static const String userListRoute = '/users';
  static const String userDetailRoute = '/users/detail';
  static const String userFormRoute = '/users/form';
  static const String roleListRoute = '/roles';
  static const String roleFormRoute = '/roles/form';
  static const String companyProfileRoute = '/company-profile';
  static const String notificationListRoute = '/notifications';
  static const String settingsRoute = '/settings';
  static const String availabilitySettingsRoute = '/availability';
  static const String slotFormRoute = '/availability/form';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case dashboardRoute:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());
      case appointmentListRoute:
        return MaterialPageRoute(builder: (_) => const AppointmentListScreen());
      case appointmentDetailRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AppointmentDetailScreen(appointmentId: args),
          );
        }
        return _errorRoute();
      case appointmentFormRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => AppointmentFormScreen(appointmentId: args),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const AppointmentFormScreen());
        }
      case userListRoute:
        return MaterialPageRoute(builder: (_) => const UserListScreen());
      case userDetailRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => UserDetailScreen(userId: args),
          );
        }
        return _errorRoute();
      case userFormRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => UserFormScreen(userId: args),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const UserFormScreen());
        }
      case roleListRoute:
        return MaterialPageRoute(builder: (_) => const RoleListScreen());
      case roleFormRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RoleFormScreen(roleId: args),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const RoleFormScreen());
        }
      case companyProfileRoute:
        return MaterialPageRoute(builder: (_) => const CompanyProfileScreen());
      case notificationListRoute:
        return MaterialPageRoute(builder: (_) => const NotificationListScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case availabilitySettingsRoute:
        return MaterialPageRoute(builder: (_) => const AvailabilitySettingsScreen());
      case slotFormRoute:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SlotFormScreen(slotId: args),
          );
        } else {
          return MaterialPageRoute(builder: (_) => const SlotFormScreen());
        }
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error: Unknown route'),
        ),
      );
    });
  }
}