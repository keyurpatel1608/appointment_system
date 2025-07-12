import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:appointment_system/core/models/notification_model.dart'; // Assuming a Notification model exists
import 'package:appointment_system/features/notifications/providers/notification_provider.dart';
import 'package:appointment_system/core/utils/date_utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications when the screen initializes
    Provider.of<NotificationProvider>(context, listen: false).fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, child) {
          if (notificationProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (notificationProvider.notifications.isEmpty) {
            return const Center(child: Text('No new notifications.'));
          } else {
            return ListView.builder(
              itemCount: notificationProvider.notifications.length,
              itemBuilder: (context, index) {
                final notification = notificationProvider.notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      notification.type == NotificationType.appointment
                          ? Icons.calendar_today
                          : notification.type == NotificationType.system
                              ? Icons.info_outline
                              : Icons.notifications,
                      color: notification.isRead ? Colors.grey : Colors.blue,
                    ),
                    title: Text(notification.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.message),
                        const SizedBox(height: 4),
                        Text(
                          DateUtil.formatDateTime(notification.timestamp),
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    trailing: notification.isRead
                        ? null
                        : const Icon(Icons.mark_email_unread, color: Colors.green),
                    onTap: () {
                      // Mark as read and potentially navigate to detail
                      notificationProvider.markAsRead(notification.id);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Notification ${notification.title} tapped.')),
                      );
                      // TODO: Implement navigation to relevant screen based on notification type/payload
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}