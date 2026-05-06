enum AuthRole { standardUser, corporate }

class AuthRoleArgs {
  AuthRoleArgs._();

  static const String roleKey = 'authRole';

  static String routeValue(AuthRole role) {
    return role == AuthRole.corporate ? 'corporate' : 'standard';
  }

  static AuthRole fromRouteValue(String? value) {
    if (value?.toLowerCase() == 'corporate') {
      return AuthRole.corporate;
    }
    return AuthRole.standardUser;
  }

  static AuthRole fromArguments(dynamic arguments) {
    if (arguments is Map) {
      final value = arguments[roleKey] as String?;
      return fromRouteValue(value);
    }
    return AuthRole.standardUser;
  }
}

extension AuthRoleTextX on AuthRole {
  String get displayName {
    return this == AuthRole.corporate ? 'Corporate User' : 'Standard User';
  }
}
