import 'package:appointment_system/core/models/base_model.dart';

enum NotificationType {
  appointmentReminder,
  appointmentUpdate,
  systemMessage,
  companyUpdate,
}

class AppNotification extends BaseModel {
  final String userId;
  final String title;
  final String body;
  final NotificationType type;
  final bool isRead;
  final String? relatedId; // e.g., appointmentId, companyId

  AppNotification({
    required this.userId,
    required this.title,
    required this.body,
    required this.type,
    this.isRead = false,
    this.relatedId,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'body': body,
      'type': type.toString().split('.').last,
      'isRead': isRead,
      'relatedId': relatedId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      userId: json['userId'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      type: NotificationType.values.firstWhere(
          (e) => e.toString().split('.').last == json['type'] as String),
      isRead: json['isRead'] as bool,
      relatedId: json['relatedId'] as String?,
      id: json['id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }
}