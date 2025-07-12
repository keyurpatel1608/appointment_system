import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/dashboard/screens/dashboard_screen.dart';
import '../../features/appointment/screens/appointment_list_screen.dart';
import '../../features/appointment/screens/appointment_detail_screen.dart';
import '../../features/appointment/screens/appointment_form_screen.dart';
import '../../features/user_management/screens/user_list_screen.dart';
import '../../features/user_management/screens/user_detail_screen.dart';
import '../../features/user_management/screens/user_form_screen.dart';
import '../../features/role_management/screens/role_list_screen.dart';
import '../../features/role_management/screens/role_form_screen.dart';
import '../../features/company/screens/company_profile_screen.dart';
import '../../features/notifications/screens/notification_list_screen.dart';
import '../../features/settings/screens/settings_screen.dart';
import '../../features/availability_management/screens/availability_settings_screen.dart';
import '../../features/availability_management/screens/slot_form_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen(); // Initial screen
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginScreen();
      },
    ),
    GoRoute(
      path: '/register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterScreen();
      },
    ),
    GoRoute(
      path: '/dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardScreen();
      },
    ),
    GoRoute(
      path: '/appointments',
      builder: (BuildContext context, GoRouterState state) {
        return const AppointmentListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'detail/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String appointmentId = state.pathParameters['id']!;
            return AppointmentDetailScreen(appointmentId: appointmentId);
          },
        ),
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) {
            return const AppointmentFormScreen();
          },
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String appointmentId = state.pathParameters['id']!;
            return AppointmentFormScreen(appointmentId: appointmentId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/users',
      builder: (BuildContext context, GoRouterState state) {
        return const UserListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'detail/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String userId = state.pathParameters['id']!;
            return UserDetailScreen(userId: userId);
          },
        ),
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) {
            return const UserFormScreen();
          },
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String userId = state.pathParameters['id']!;
            return UserFormScreen(userId: userId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/roles',
      builder: (BuildContext context, GoRouterState state) {
        return const RoleListScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add',
          builder: (BuildContext context, GoRouterState state) {
            return const RoleFormScreen();
          },
        ),
        GoRoute(
          path: 'edit/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String roleId = state.pathParameters['id']!;
            return RoleFormScreen(roleId: roleId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/company-profile',
      builder: (BuildContext context, GoRouterState state) {
        return const CompanyProfileScreen();
      },
    ),
    GoRoute(
      path: '/notifications',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificationListScreen();
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (BuildContext context, GoRouterState state) {
        return const SettingsScreen();
      },
    ),
    GoRoute(
      path: '/availability',
      builder: (BuildContext context, GoRouterState state) {
        return const AvailabilitySettingsScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'add-slot',
          builder: (BuildContext context, GoRouterState state) {
            return const SlotFormScreen();
          },
        ),
        GoRoute(
          path: 'edit-slot/:id',
          builder: (BuildContext context, GoRouterState state) {
            final String slotId = state.pathParameters['id']!;
            return SlotFormScreen(slotId: slotId);
          },
        ),
      ],
    ),
  ],
);