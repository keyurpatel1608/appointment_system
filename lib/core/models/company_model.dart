import 'package:appointment_system/core/models/base_model.dart';

class Company extends BaseModel {
  final String name;
  final String ownerId;
  final String industry;

  Company({
    required this.name,
    required this.ownerId,
    required this.industry,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ownerId': ownerId,
      'industry': industry,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      industry: json['industry'] as String,
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