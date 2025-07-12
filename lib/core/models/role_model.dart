import 'package:appointment_system/core/models/base_model.dart';

class Role extends BaseModel {
  final String name;
  final String description;
  final String companyId; // 'global' for super admin roles, otherwise company ID
  final List<String> permissions;
  final int level; // For hierarchy, e.g., CEO: 1, Manager: 2, Employee: 3

  Role({
    required this.name,
    required this.description,
    required this.companyId,
    required this.permissions,
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
      'companyId': companyId,
      'permissions': permissions,
      'level': level,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      name: json['name'] as String,
      description: json['description'] as String,
      companyId: json['companyId'] as String,
      permissions: List<String>.from(json['permissions'] as List),
      level: json['level'] as int,
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