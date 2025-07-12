import 'package:appointment_system/core/models/base_model.dart';

enum SlotStatus {
  available,
  booked,
  unavailable,
}

class Slot extends BaseModel {
  final String userId; // The user who owns this slot (e.g., a doctor, a consultant)
  final DateTime startTime;
  final DateTime endTime;
  final SlotStatus status;
  final String? appointmentId; // Link to the appointment if booked
  final String companyId;

  Slot({
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.companyId,
    this.status = SlotStatus.available,
    this.appointmentId,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status.toString().split('.').last,
      'appointmentId': appointmentId,
      'companyId': companyId,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Slot.fromJson(Map<String, dynamic> json) {
    return Slot(
      userId: json['userId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      companyId: json['companyId'] as String,
      status: SlotStatus.values.firstWhere(
          (e) => e.toString().split('.').last == json['status'] as String),
      appointmentId: json['appointmentId'] as String?,
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