import 'package:appointment_system/core/models/base_model.dart';

enum PermissionCategory {
  USER_MANAGEMENT,
  ROLE_MANAGEMENT,
  APPOINTMENT_MANAGEMENT,
  CALENDAR_MANAGEMENT,
  COMPANY_SETTINGS,
  FINANCIAL_OPERATIONS,
  REPORTING,
  NOTIFICATIONS,
  SYSTEM_ADMIN
}

enum PermissionLevel {
  NONE,
  READ,
  WRITE,
  DELETE,
  FULL_ACCESS,
  ADMIN
}

class Permission extends BaseModel {
  final String name;
  final String description;
  final PermissionCategory category;
  final PermissionLevel level;

  Permission({
    required this.name,
    required this.description,
    required this.category,
    required this.level,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id: id, createdAt: createdAt, updatedAt: updatedAt);

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'category': category.toString().split('.').last,
      'level': level.toString().split('.').last,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      name: json['name'] as String,
      description: json['description'] as String,
      category: PermissionCategory.values.firstWhere(
          (e) => e.toString().split('.').last == json['category'] as String),
      level: PermissionLevel.values.firstWhere(
          (e) => e.toString().split('.').last == json['level'] as String),
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