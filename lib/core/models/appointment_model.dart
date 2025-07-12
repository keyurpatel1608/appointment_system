import 'package:appointment_system/core/models/base_model.dart';

enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

class Appointment extends BaseModel {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String userId;
  final String targetUserId; // The user with whom the appointment is scheduled
  final String companyId;
  final AppointmentStatus status;

  Appointment({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.userId,
    required this.targetUserId,
    required this.companyId,
    this.status = AppointmentStatus.pending,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'userId': userId,
      'targetUserId': targetUserId,
      'companyId': companyId,
      'status': status.toString().split('.').last,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      title: json['title'] as String,
      description: json['description'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      userId: json['userId'] as String,
      targetUserId: json['targetUserId'] as String,
      companyId: json['companyId'] as String,
      status: AppointmentStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'] as String),
      id: json['id'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Appointment copyWith({
    String? title,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    String? userId,
    String? targetUserId,
    String? companyId,
    AppointmentStatus? status,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Appointment(
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      userId: userId ?? this.userId,
      targetUserId: targetUserId ?? this.targetUserId,
      companyId: companyId ?? this.companyId,
      status: status ?? this.status,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}