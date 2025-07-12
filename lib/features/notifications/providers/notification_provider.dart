import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  List<AppNotification> _notifications = [];
  bool _isLoading = false;

  List<AppNotification> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> fetchNotifications() async {
    _isLoading = true;
    notifyListeners();
    // Simulate fetching data from a backend
    await Future.delayed(const Duration(seconds: 1));
    _notifications = [
      AppNotification(
        id: 'notif1',
        title: 'New Appointment Scheduled',
        message: 'You have a new appointment with John Doe on 2023-10-27 at 10:00 AM.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        type: NotificationType.appointment,
        relatedEntityId: 'appt123',
        isRead: false,
      ),
      AppNotification(
        id: 'notif2',
        title: 'System Update',
        message: 'The system will be undergoing maintenance tonight from 1 AM to 3 AM.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: NotificationType.system,
        isRead: false,
      ),
      AppNotification(
        id: 'notif3',
        title: 'Appointment Cancelled',
        message: 'Your appointment with Jane Smith on 2023-10-26 has been cancelled.',
        timestamp: DateTime.now().subtract(const Duration(days: 1)),
        type: NotificationType.appointment,
        relatedEntityId: 'appt456',
        isRead: true,
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }

  void markAsRead(String notificationId) {
    final index = _notifications.indexWhere((notif) => notif.id == notificationId);
    if (index != -1) {
      _notifications[index].isRead = true;
      notifyListeners();
    }
  }

  void addNotification(AppNotification notification) {
    _notifications.insert(0, notification); // Add to the beginning
    notifyListeners();
  }

  void clearAllNotifications() {
    _notifications = [];
    notifyListeners();
  }
}