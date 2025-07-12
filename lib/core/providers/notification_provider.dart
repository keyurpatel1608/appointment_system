import 'package:flutter/material.dart';
import 'package:appointment_system/core/models/notification_model.dart';
import 'package:appointment_system/core/services/firestore_service.dart';

class NotificationProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<AppNotification> _notifications = [];

  List<AppNotification> get notifications => _notifications;

  Future<void> fetchNotifications(String userId) async {
    // In a real app, you'd query notifications for a specific user
    _notifications = await _firestoreService.streamCollection<AppNotification>('users/$userId/notifications', AppNotification.fromJson).first;
    notifyListeners();
  }

  Future<void> markAsRead(AppNotification notification) async {
    final updatedNotification = AppNotification(
      id: notification.id,
      userId: notification.userId,
      title: notification.title,
      body: notification.body,
      type: notification.type,
      isRead: true,
      relatedId: notification.relatedId,
      createdAt: notification.createdAt,
      updatedAt: DateTime.now(),
    );
    await _firestoreService.updateDocument('users/${notification.userId}/notifications', notification.id!, updatedNotification.toJson());
    await fetchNotifications(notification.userId);
  }
}