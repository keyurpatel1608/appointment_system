# Business Appointment Management System - Complete Specification

## 🏗️ System Architecture & Flow

### User Role Hierarchy (Dynamic System)
1. **Super Admin** - System-wide control (Global)
2. **Company-Specific Roles** (Dynamic per company):
   - **CEO** - Company owner/founder (Default)
   - **Manager** - Department heads (Default)
   - **Employee** - Regular staff (Default)
   - **HR** - Human Resources (Custom)
   - **Finance** - Financial team (Custom)
   - **Sales** - Sales team (Custom)
   - **Visitor** - External users (Default)
   - **[Custom Roles]** - Company-defined roles

### Dynamic Role System Features
- **Default Role Templates**: Every company gets basic roles (CEO, Manager, Employee, Visitor)
- **Custom Role Creation**: Companies can create unlimited custom roles
- **Flexible Permission Assignment**: Each role can have different permissions per company
- **Role Hierarchy Management**: Companies define their own role hierarchy
- **Permission Inheritance**: Child roles can inherit parent permissions
- **Role Cloning**: Create new roles based on existing ones

### Main Application Flow

```
Authentication → Role Detection → Dashboard Routing → Module Access Control
```

## 📋 Complete Module List

### 1. Authentication Module
- Login/Register
- Role-based onboarding
- Company registration (by Super Admin or self-registration)
- CEO creation by Super Admin
- Password reset

### 2. User Management Module
- User CRUD operations
- Role assignment
- Profile management
- Company user listing

### 3. Role & Permission Management Module
- Dynamic role creation per company
- Custom permission assignment
- Role hierarchy management
- Permission inheritance system
- Role templates and cloning
- Company-specific RBAC matrix
- Permission conflict resolution
- Role audit logs

### 4. Appointment Management Module
- Appointment booking
- Conflict detection
- Rescheduling
- Appointment history
- Status management

### 5. Calendar Management Module
- Slot configuration
- Availability management
- Calendar views
- Time zone handling

### 6. Dashboard Module
- Role-based dashboards
- Statistics display
- Quick actions
- Recent activities

### 7. Admin Panel Module
- System administration
- Company management
- User oversight
- Settings configuration

### 8. Notification Module
- FCM integration
- In-app notifications
- Notification history
- Preferences management

### 9. Profile & Settings Module
- User profile editing
- Company settings
- Preferences
- Account management

## 🗂️ Complete File Structure

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── config/
│   │   ├── app_config.dart
│   │   ├── firebase_config.dart
│   │   └── theme_config.dart
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── route_constants.dart
│   │   └── permission_constants.dart
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── company_model.dart
│   │   ├── appointment_model.dart
│   │   ├── role_model.dart
│   │   ├── permission_model.dart
│   │   ├── notification_model.dart
│   │   ├── slot_model.dart
│   │   └── base_model.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   ├── firestore_service.dart
│   │   ├── notification_service.dart
│   │   ├── permission_service.dart
│   │   ├── calendar_service.dart
│   │   └── storage_service.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── date_utils.dart
│   │   ├── app_utils.dart
│   │   └── permission_utils.dart
│   └── providers/
│       ├── auth_provider.dart
│       ├── user_provider.dart
│       ├── appointment_provider.dart
│       ├── role_provider.dart
│       └── notification_provider.dart
├── features/
│   ├── auth/
│   │   ├── screens/
│   │   │   ├── login_screen.dart
│   │   │   ├── register_screen.dart
│   │   │   ├── onboarding_screen.dart
│   │   │   ├── company_registration_screen.dart
│   │   │   └── ceo_creation_screen.dart
│   │   ├── widgets/
│   │   │   ├── auth_form.dart
│   │   │   ├── role_selector.dart
│   │   │   └── company_form.dart
│   │   └── providers/
│   │       └── auth_provider.dart
│   ├── dashboard/
│   │   ├── screens/
│   │   │   ├── super_admin_dashboard.dart
│   │   │   ├── ceo_dashboard.dart
│   │   │   ├── manager_dashboard.dart
│   │   │   ├── employee_dashboard.dart
│   │   │   └── visitor_dashboard.dart
│   │   ├── widgets/
│   │   │   ├── stats_card.dart
│   │   │   ├── recent_appointments.dart
│   │   │   ├── quick_actions.dart
│   │   │   └── dashboard_chart.dart
│   │   └── providers/
│   │       └── dashboard_provider.dart
│   ├── appointment/
│   │   ├── screens/
│   │   │   ├── appointment_list_screen.dart
│   │   │   ├── appointment_detail_screen.dart
│   │   │   ├── book_appointment_screen.dart
│   │   │   ├── reschedule_screen.dart
│   │   │   └── appointment_history_screen.dart
│   │   ├── widgets/
│   │   │   ├── appointment_card.dart
│   │   │   ├── time_slot_picker.dart
│   │   │   ├── conflict_dialog.dart
│   │   │   └── appointment_form.dart
│   │   └── providers/
│   │       └── appointment_provider.dart
│   ├── calendar/
│   │   ├── screens/
│   │   │   ├── calendar_screen.dart
│   │   │   ├── availability_settings_screen.dart
│   │   │   └── slot_management_screen.dart
│   │   ├── widgets/
│   │   │   ├── calendar_widget.dart
│   │   │   ├── slot_editor.dart
│   │   │   ├── availability_grid.dart
│   │   │   └── time_range_picker.dart
│   │   └── providers/
│   │       └── calendar_provider.dart
│   ├── admin/
│   │   ├── screens/
│   │   │   ├── admin_dashboard.dart
│   │   │   ├── company_management_screen.dart
│   │   │   ├── ceo_management_screen.dart
│   │   │   ├── user_management_screen.dart
│   │   │   ├── role_management_screen.dart
│   │   │   ├── custom_role_creation_screen.dart
│   │   │   ├── permission_assignment_screen.dart
│   │   │   ├── role_hierarchy_screen.dart
│   │   │   ├── role_templates_screen.dart
│   │   │   ├── company_settings_screen.dart
│   │   │   └── system_logs_screen.dart
│   │   ├── widgets/
│   │   │   ├── user_list_tile.dart
│   │   │   ├── company_card.dart
│   │   │   ├── ceo_form.dart
│   │   │   ├── role_editor.dart
│   │   │   ├── custom_role_builder.dart
│   │   │   ├── permission_selector.dart
│   │   │   ├── role_hierarchy_tree.dart
│   │   │   ├── permission_matrix.dart
│   │   │   └── settings_form.dart
│   │   └── providers/
│   │       ├── admin_provider.dart
│   │       ├── company_management_provider.dart
│   │       ├── ceo_management_provider.dart
│   │       ├── user_management_provider.dart
│   │       └── role_management_provider.dart
│   ├── notifications/
│   │   ├── screens/
│   │   │   ├── notification_list_screen.dart
│   │   │   └── notification_settings_screen.dart
│   │   ├── widgets/
│   │   │   ├── notification_tile.dart
│   │   │   └── notification_settings_form.dart
│   │   └── providers/
│   │       └── notification_provider.dart
│   └── profile/
│       ├── screens/
│       │   ├── profile_screen.dart
│       │   ├── edit_profile_screen.dart
│       │   └── settings_screen.dart
│       ├── widgets/
│       │   ├── profile_form.dart
│       │   └── settings_list.dart
│       └── providers/
│           └── profile_provider.dart
├── routes/
│   ├── app_router.dart
│   ├── route_generator.dart
│   └── permission_guard.dart
└── widgets/
    ├── common/
    │   ├── custom_app_bar.dart
    │   ├── custom_button.dart
    │   ├── custom_text_field.dart
    │   ├── loading_widget.dart
    │   ├── error_widget.dart
    │   └── permission_wrapper.dart
    ├── navigation/
    │   ├── bottom_nav_bar.dart
    │   ├── drawer_menu.dart
    │   └── nav_item.dart
    └── dialogs/
        ├── confirmation_dialog.dart
        ├── info_dialog.dart
        └── error_dialog.dart
```

## 🔐 Dynamic Role-Based Access Control System

### Company-Specific Role System

Each company operates independently with its own role structure:

#### Example Company A (Tech Startup)
```
CEO (Level 1)
├── CTO (Level 2)
│   ├── Senior Developer (Level 3)
│   └── Junior Developer (Level 4)
├── Marketing Head (Level 2)
│   ├── Content Manager (Level 3)
│   └── Social Media Manager (Level 3)
└── HR Manager (Level 2)
    └── HR Assistant (Level 3)
```

#### Example Company B (Manufacturing)
```
CEO (Level 1)
├── Plant Manager (Level 2)
│   ├── Production Supervisor (Level 3)
│   ├── Quality Control Manager (Level 3)
│   └── Safety Officer (Level 3)
├── Sales Director (Level 2)
│   ├── Regional Sales Manager (Level 3)
│   └── Sales Representative (Level 4)
└── Finance Manager (Level 2)
    └── Accountant (Level 3)
```

### Dynamic Permission System

#### Permission Categories
```dart
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
```

#### Permission Levels
```dart
enum PermissionLevel {
  NONE,           // No access
  READ,           // View only
  WRITE,          // Create/Edit
  DELETE,         // Remove
  FULL_ACCESS,    // All operations
  ADMIN           // Administrative control
}
```

### Role-Based Access Control Matrix (Dynamic)

**Base Template for All Companies:**
| Module | CEO | Manager | Employee | Visitor |
|--------|-----|---------|----------|---------|
| **User Management** | ✅ Full | ✅ Team | ❌ | ❌ |
| **Role Management** | ✅ Full | ✅ View | ❌ | ❌ |
| **Appointments** | ✅ All | ✅ Team | ✅ Own | ✅ Own |
| **Calendar** | ✅ Manage | ✅ View Team | ✅ View CEO | ✅ View CEO |
| **Company Settings** | ✅ Full | ❌ | ❌ | ❌ |

**Company A Custom Roles:**
| Module | CTO | Marketing Head | HR Manager |
|--------|-----|----------------|-------------|
| **User Management** | ✅ Tech Team | ✅ Marketing Team | ✅ All Users |
| **Role Management** | ✅ Tech Roles | ✅ Marketing Roles | ✅ All Roles |
| **Appointments** | ✅ Tech Team | ✅ Marketing Team | ✅ All Users |
| **Calendar** | ✅ Tech Calendar | ✅ Marketing Calendar | ✅ Company Calendar |
| **Company Settings** | ✅ Tech Settings | ✅ Marketing Settings | ✅ HR Settings |

**Company B Custom Roles:**
| Module | Plant Manager | Sales Director | Finance Manager |
|--------|---------------|----------------|-----------------|
| **User Management** | ✅ Production Team | ✅ Sales Team | ✅ Finance Team |
| **Role Management** | ✅ Production Roles | ✅ Sales Roles | ✅ Finance Roles |
| **Appointments** | ✅ Production | ✅ Sales | ✅ Finance |
| **Calendar** | ✅ Production Schedule | ✅ Sales Calendar | ✅ Finance Calendar |
| **Company Settings** | ✅ Production Settings | ✅ Sales Settings | ✅ Finance Settings |

### File-wise RBAC Permissions

#### Authentication Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `login_screen.dart` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `register_screen.dart` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `onboarding_screen.dart` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `company_registration_screen.dart` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `ceo_creation_screen.dart` | ✅ | ❌ | ❌ | ❌ | ❌ |

#### Dashboard Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `super_admin_dashboard.dart` | ✅ | ❌ | ❌ | ❌ | ❌ |
| `ceo_dashboard.dart` | ✅ | ✅ | ❌ | ❌ | ❌ |
| `manager_dashboard.dart` | ✅ | ✅ | ✅ | ❌ | ❌ |
| `employee_dashboard.dart` | ✅ | ✅ | ✅ | ✅ | ❌ |
| `visitor_dashboard.dart` | ✅ | ✅ | ✅ | ✅ | ✅ |

#### Appointment Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `appointment_list_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ✅ Own |
| `appointment_detail_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ✅ Own |
| `book_appointment_screen.dart` | ✅ | ✅ | ✅ | ✅ | ✅ |
| `reschedule_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ❌ |
| `appointment_history_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ✅ Own |

#### Calendar Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `calendar_screen.dart` | ✅ All | ✅ Own | ✅ View Team | ✅ View CEO | ✅ View CEO |
| `availability_settings_screen.dart` | ✅ All | ✅ Own | ❌ | ❌ | ❌ |
| `slot_management_screen.dart` | ✅ All | ✅ Own | ❌ | ❌ | ❌ |

#### Admin Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `admin_dashboard.dart` | ✅ | ✅ | ✅ Limited | ❌ | ❌ |
| `company_management_screen.dart` | ✅ | ❌ | ❌ | ❌ | ❌ |
| `ceo_management_screen.dart` | ✅ | ❌ | ❌ | ❌ | ❌ |
| `user_management_screen.dart` | ✅ All | ✅ Company | ✅ Team | ❌ | ❌ |
| `role_management_screen.dart` | ✅ All | ✅ Company | ✅ View | ❌ | ❌ |
| `company_settings_screen.dart` | ✅ All | ✅ Own | ❌ | ❌ | ❌ |
| `system_logs_screen.dart` | ✅ | ❌ | ❌ | ❌ | ❌ |

#### Notification Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `notification_list_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ✅ Own |
| `notification_settings_screen.dart` | ✅ All | ✅ Own | ✅ Own | ✅ Own | ✅ Own |

#### Profile Module Files
| File | Super Admin | CEO | Manager | Employee | Visitor |
|------|-------------|-----|---------|----------|---------|
| `profile_screen.dart` | ✅ All | ✅ Company | ✅ Team | ✅ Own | ✅ Own |
| `edit_profile_screen.dart` | ✅ All | ✅ Own | ✅ Own | ✅ Own | ✅ Own |
| `settings_screen.dart` | ✅ System | ✅ Company | ✅ Personal | ✅ Personal | ✅ Personal |

## 🔄 Application Flow Chart

```
START
├── App Launch
├── Firebase Initialization
├── Authentication Check
│   ├── Not Authenticated → Login/Register
│   └── Authenticated → Role Detection
├── Role Detection
│   ├── Super Admin → System Dashboard
│   ├── CEO → Company Dashboard
│   ├── Manager → Team Dashboard
│   ├── Employee → Personal Dashboard
│   └── Visitor → Visitor Dashboard
├── Navigation Based on Role
├── Permission Guard on Each Route
├── Module Access Control
└── END
```

## 🎯 Detailed Permission Constants

### Permission Types
```dart
class PermissionConstants {
  // User Management
  static const String CREATE_USER = 'create_user';
  static const String READ_USER = 'read_user';
  static const String UPDATE_USER = 'update_user';
  static const String DELETE_USER = 'delete_user';
  
  // Company Management
  static const String CREATE_COMPANY = 'create_company';
  static const String READ_COMPANY = 'read_company';
  static const String UPDATE_COMPANY = 'update_company';
  static const String DELETE_COMPANY = 'delete_company';
  
  // CEO Management
  static const String CREATE_CEO = 'create_ceo';
  static const String ASSIGN_CEO = 'assign_ceo';
  static const String UPDATE_CEO = 'update_ceo';
  
  // Role Management
  static const String CREATE_ROLE = 'create_role';
  static const String READ_ROLE = 'read_role';
  static const String UPDATE_ROLE = 'update_role';
  static const String DELETE_ROLE = 'delete_role';
  
  // Appointment Management
  static const String CREATE_APPOINTMENT = 'create_appointment';
  static const String READ_APPOINTMENT = 'read_appointment';
  static const String UPDATE_APPOINTMENT = 'update_appointment';
  static const String DELETE_APPOINTMENT = 'delete_appointment';
  static const String RESCHEDULE_APPOINTMENT = 'reschedule_appointment';
  
  // Calendar Management
  static const String MANAGE_CALENDAR = 'manage_calendar';
  static const String VIEW_CALENDAR = 'view_calendar';
  static const String SET_AVAILABILITY = 'set_availability';
  
  // Company Management
  static const String MANAGE_COMPANY = 'manage_company';
  static const String VIEW_COMPANY_STATS = 'view_company_stats';
  
  // System Administration
  static const String SYSTEM_ADMIN = 'system_admin';
  static const String VIEW_SYSTEM_LOGS = 'view_system_logs';
}
```

## 🔗 Firestore Security Rules Structure

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Companies collection
    match /companies/{companyId} {
      allow read, write: if request.auth != null && 
        (resource.data.ownerId == request.auth.uid || 
         hasRole(request.auth.uid, companyId, ['super_admin', 'ceo']));
      
      // Company-specific roles subcollection
      match /roles/{roleId} {
        allow read: if request.auth != null && 
          belongsToCompany(request.auth.uid, companyId);
        allow write: if request.auth != null && 
          (hasPermission(request.auth.uid, companyId, 'manage_roles') ||
           hasRole(request.auth.uid, companyId, ['super_admin', 'ceo']));
      }
      
      // Custom permissions subcollection
      match /permissions/{permissionId} {
        allow read: if request.auth != null && 
          belongsToCompany(request.auth.uid, companyId);
        allow write: if request.auth != null && 
          hasPermission(request.auth.uid, companyId, 'manage_permissions');
      }
      
      // Role templates subcollection
      match /role_templates/{templateId} {
        allow read: if request.auth != null;
        allow write: if request.auth != null && 
          hasRole(request.auth.uid, companyId, ['super_admin', 'ceo']);
      }
      
      // Users subcollection
      match /users/{userId} {
        allow read: if request.auth != null && 
          (request.auth.uid == userId || 
           hasPermission(request.auth.uid, companyId, 'read_user'));
        allow write: if request.auth != null && 
          hasPermission(request.auth.uid, companyId, 'update_user');
      }
      
      // Appointments subcollection
      match /appointments/{appointmentId} {
        allow read: if request.auth != null && 
          (resource.data.userId == request.auth.uid || 
           resource.data.targetUserId == request.auth.uid ||
           hasPermission(request.auth.uid, companyId, 'read_appointment'));
        allow write: if request.auth != null && 
          hasPermission(request.auth.uid, companyId, 'create_appointment');
      }
    }
    
    // Global role templates (available to all companies)
    match /global_role_templates/{templateId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        hasRole(request.auth.uid, 'system', ['super_admin']);
    }
    
    // System-wide permissions catalog
    match /system_permissions/{permissionId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        hasRole(request.auth.uid, 'system', ['super_admin']);
    }
  }
  
  // Helper functions
  function belongsToCompany(uid, companyId) {
    return get(/databases/$(database)/documents/companies/$(companyId)/users/$(uid)).data.companyId == companyId;
  }
  
  function hasRole(uid, companyId, roles) {
    let userRole = get(/databases/$(database)/documents/companies/$(companyId)/users/$(uid)).data.roleId;
    let roleData = get(/databases/$(database)/documents/companies/$(companyId)/roles/$(userRole)).data;
    return roleData.name in roles;
  }
  
  function hasPermission(uid, companyId, permission) {
    let userRole = get(/databases/$(database)/documents/companies/$(companyId)/users/$(uid)).data.roleId;
    let roleData = get(/databases/$(database)/documents/companies/$(companyId)/roles/$(userRole)).data;
    return permission in roleData.permissions || 
           permission in roleData.inheritedPermissions;
  }
}
```

## 📊 Data Models Structure

### User Model
```dart
class UserModel {
  final String id;
  final String email;
  final String name;
  final String companyId;
  final String roleId;
  final String profilePicture;
  final bool isActive;
  final DateTime createdAt;
  final DateTime lastLogin;
  final Map<String, dynamic> metadata;
}
```

### Extended Role Model (Dynamic)
```dart
class RoleModel {
  final String id;
  final String name;
  final String description;
  final String companyId;
  final String? parentRoleId;          // For hierarchy
  final int level;                     // Role level in hierarchy
  final List<String> permissions;
  final List<String> inheritedPermissions; // From parent roles
  final Map<String, PermissionLevel> modulePermissions;
  final List<String> allowedDepartments;
  final List<String> restrictedActions;
  final RoleType type;                 // DEFAULT, CUSTOM, TEMPLATE
  final bool isActive;
  final bool canCreateSubRoles;
  final DateTime createdAt;
  final String createdBy;
  final Map<String, dynamic> customSettings;
}

enum RoleType { DEFAULT, CUSTOM, TEMPLATE }
```

### Permission Model (Granular)
```dart
class PermissionModel {
  final String id;
  final String name;
  final String description;
  final PermissionCategory category;
  final PermissionLevel level;
  final String module;
  final List<String> dependencies;     // Required permissions
  final List<String> conflicts;       // Conflicting permissions
  final bool isCustom;
  final String? companyId;            // null for system permissions
  final Map<String, dynamic> constraints;
}
```

### Role Template Model
```dart
class RoleTemplateModel {
  final String id;
  final String name;
  final String description;
  final String industry;              // TECH, MANUFACTURING, HEALTHCARE, etc.
  final List<String> defaultPermissions;
  final Map<String, dynamic> template;
  final bool isPublic;
  final int usageCount;
  final double rating;
  final DateTime createdAt;
}
```

### Permission Group Model
```dart
class PermissionGroupModel {
  final String id;
  final String name;
  final String description;
  final List<String> permissions;
  final String companyId;
  final bool isDefault;
  final DateTime createdAt;
}
```

### Dynamic Role Management Features

#### 1. Role Templates by Industry
```dart
// Tech Company Template
final techTemplate = RoleTemplateModel(
  id: 'tech_template_001',
  name: 'Tech Startup Roles',
  industry: 'TECHNOLOGY',
  defaultPermissions: [
    'CTO', 'Senior Developer', 'Junior Developer',
    'DevOps Engineer', 'UI/UX Designer', 'Product Manager'
  ],
  template: {
    'CTO': ['manage_tech_team', 'code_review', 'architecture_decisions'],
    'Senior Developer': ['code_review', 'mentor_junior', 'tech_design'],
    'Junior Developer': ['code_write', 'bug_fix', 'learn_tech'],
  }
);

// Manufacturing Template
final manufacturingTemplate = RoleTemplateModel(
  id: 'manufacturing_template_001',
  name: 'Manufacturing Plant Roles',
  industry: 'MANUFACTURING',
  defaultPermissions: [
    'Plant Manager', 'Production Supervisor', 'Quality Control',
    'Safety Officer', 'Machine Operator', 'Maintenance Tech'
  ],
  template: {
    'Plant Manager': ['manage_production', 'safety_oversight', 'quality_control'],
    'Production Supervisor': ['schedule_production', 'manage_operators'],
    'Quality Control': ['inspect_products', 'quality_reports'],
  }
);
```

#### 2. Permission Inheritance System
```dart
class PermissionInheritanceService {
  List<String> calculateInheritedPermissions(String roleId, String companyId) {
    // Get role hierarchy
    final role = getRoleById(roleId);
    final inheritedPerms = <String>[];
    
    // Traverse up the hierarchy
    if (role.parentRoleId != null) {
      final parentPermissions = calculateInheritedPermissions(
        role.parentRoleId!, 
        companyId
      );
      inheritedPerms.addAll(parentPermissions);
    }
    
    // Add own permissions
    inheritedPerms.addAll(role.permissions);
    
    return inheritedPerms.toSet().toList(); // Remove duplicates
  }
}
```

#### 3. Dynamic Permission Checking
```dart
class PermissionService {
  bool hasPermission(String userId, String permission, {String? context}) {
    final user = getUserById(userId);
    final role = getRoleById(user.roleId);
    
    // Check direct permissions
    if (role.permissions.contains(permission)) return true;
    
    // Check inherited permissions
    final inheritedPerms = calculateInheritedPermissions(user.roleId, user.companyId);
    if (inheritedPerms.contains(permission)) return true;
    
    // Check module-level permissions
    final modulePermission = extractModuleFromPermission(permission);
    final userModuleLevel = role.modulePermissions[modulePermission];
    final requiredLevel = getRequiredPermissionLevel(permission);
    
    return userModuleLevel != null && 
           userModuleLevel.index >= requiredLevel.index;
  }
}
```

#### 4. Company-Specific Role Creation Flow
```
CEO/Admin Dashboard → Role Management → Create Custom Role
├── Select Base Template (optional)
├── Define Role Name & Description
├── Set Role Level in Hierarchy
├── Select Parent Role (if applicable)
├── Choose Permissions by Category
├── Set Module-Level Permissions
├── Configure Department Access
├── Set Constraints & Restrictions
├── Preview Permission Matrix
├── Save & Test Role
└── Assign to Users
```

### Appointment Model
```dart
class AppointmentModel {
  final String id;
  final String userId;
  final String targetUserId;
  final String companyId;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final AppointmentStatus status;
  final String? rescheduleReason;
  final DateTime createdAt;
  final DateTime? rescheduledAt;
}
```

This comprehensive specification provides a complete foundation for building your business appointment management system with robust role-based access control, modular architecture, and clear separation of concerns.

## 🏢 Super Admin Company & CEO Management

### Super Admin Capabilities

The Super Admin has exclusive system-wide privileges to:

#### Company Management
- **Create Companies**: Add new companies to the system
- **View All Companies**: Access complete list of all companies
- **Update Company Details**: Modify company information, settings, and status
- **Deactivate/Activate Companies**: Control company access to the system
- **Delete Companies**: Remove companies (with proper safeguards)
- **View Company Statistics**: Access analytics for all companies

#### CEO Management
- **Create CEOs**: Add new CEO users for any company
- **Assign CEOs**: Assign CEO role to existing users
- **Transfer CEO Role**: Move CEO privileges between users
- **Update CEO Details**: Modify CEO information and permissions
- **Deactivate CEOs**: Temporarily disable CEO access
- **View CEO Activities**: Monitor CEO actions across all companies

### Company Creation Flow (Super Admin)
```
Super Admin Dashboard → Company Management → Create Company
├── Company Details Form
├── Initial Settings Configuration
├── Create Company Record
├── Generate Company-specific Roles
├── Send Company Credentials
└── Redirect to CEO Creation
```

### CEO Creation Flow (Super Admin)
```
Company Management → CEO Management → Create CEO
├── Select Target Company
├── CEO Details Form
├── Generate CEO Credentials
├── Assign CEO Role & Permissions
├── Send Welcome Email
├── Create Default Availability
└── Notify Company of CEO Assignment
```

### Alternative Company Registration
Companies can also self-register through the normal registration flow:
```
Public Registration → Company Registration → CEO Self-Registration
├── Company founder creates account
├── Registers company details
├── Automatically becomes CEO
├── Super Admin approval (optional)
└── Company activation
```

### RBAC for Company/CEO Management

| Action | Super Admin | CEO | Manager | Employee | Visitor |
|--------|-------------|-----|---------|----------|---------|
| **Create Company** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **View All Companies** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Update Any Company** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Delete Company** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Create CEO** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Assign CEO Role** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **Transfer CEO** | ✅ | ❌ | ❌ | ❌ | ❌ |
| **View CEO List** | ✅ All | ❌ | ❌ | ❌ | ❌ |
| **Self-Register Company** | ✅ | ✅ | ❌ | ❌ | ❌ |

### Data Models for Company/CEO Management

#### Company Model (Extended)
```dart
class CompanyModel {
  final String id;
  final String name;
  final String description;
  final String industry;
  final String address;
  final String phone;
  final String email;
  final String website;
  final String logoUrl;
  final String ceoId;
  final CompanyStatus status;
  final DateTime createdAt;
  final String createdBy; // Super Admin ID
  final Map<String, dynamic> settings;
  final List<String> activeModules;
  final int employeeCount;
  final PlanType planType;
  final DateTime? planExpiresAt;
}
```

#### CEO Assignment Model
```dart
class CEOAssignmentModel {
  final String id;
  final String companyId;
  final String userId;
  final String previousCEOId;
  final String assignedBy; // Super Admin ID
  final DateTime assignedAt;
  final String reason;
  final bool isActive;
}
```