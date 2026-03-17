import 'package:airportshuttle4less/domain/entities/user.dart';

/// User response model from API
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? profileImage;
  final DateTime? createdAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.profileImage,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String? readString(String a, [String? b]) =>
        (json[a] ?? (b != null ? json[b] : null))?.toString().trim();
    String? readAny(Iterable<String> keys) {
      for (final k in keys) {
        final v = json[k]?.toString().trim();
        if (v != null && v.isNotEmpty) return v;
      }
      return null;
    }

    final id = readString('id', 'Id') ?? '';
    // Name: try Name/name, else build from FirstName + LastName (API Register uses these)
    String name = readString('name', 'Name') ?? '';
    if (name.isEmpty) {
      final first = readString('firstName', 'FirstName');
      final last = readString('lastName', 'LastName');
      name = [
        first,
        last,
      ].whereType<String>().where((s) => s.isNotEmpty).join(' ').trim();
    }
    final email = readString('email', 'Email') ?? '';
    // Phone: try common API/database key variants
    final phone =
        readAny([
          'phone',
          'Phone',
          'PhoneNumber',
          'phone_number',
          'Mobile',
          'MobileNumber',
          'Cell',
          'CellPhone',
          'Telephone',
          'Tel',
          'ContactNo',
          'ContactNumber',
          'PhoneNo',
        ]) ??
        '';
    final role = readString('role', 'Role') ?? 'user';
    final profileImage = readString('profile_image', 'ProfileImage');
    final createdAtRaw = json['created_at'] ?? json['CreatedAt'];
    final createdAt = createdAtRaw != null
        ? DateTime.tryParse(createdAtRaw.toString())
        : null;
    return UserModel(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: role,
      profileImage: profileImage,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'profile_image': profileImage,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  /// Convert to domain entity
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      phone: phone,
      role: role,
      profileImage: profileImage,
      createdAt: createdAt,
    );
  }

  /// Create from domain entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      phone: user.phone,
      role: user.role,
      profileImage: user.profileImage,
      createdAt: user.createdAt,
    );
  }
}
