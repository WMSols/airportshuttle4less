/// Login request model for API
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  /// API expects PascalCase: { "Email": "...", "Password": "..." }
  Map<String, dynamic> toJson() {
    return {'Email': email, 'Password': password};
  }
}
