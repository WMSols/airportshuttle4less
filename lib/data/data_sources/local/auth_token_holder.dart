/// In-memory token holder for JWT authentication
class AuthTokenHolder {
  static AuthTokenHolder? _instance;
  
  String? _accessToken;
  String? _refreshToken;
  DateTime? _tokenExpiry;

  AuthTokenHolder._();

  static AuthTokenHolder get instance {
    _instance ??= AuthTokenHolder._();
    return _instance!;
  }

  /// Get current access token
  String? get accessToken => _accessToken;

  /// Get current refresh token
  String? get refreshToken => _refreshToken;

  /// Check if token is valid
  bool get isTokenValid {
    if (_accessToken == null || _tokenExpiry == null) return false;
    return DateTime.now().isBefore(_tokenExpiry!);
  }

  /// Set tokens
  void setTokens({
    required String accessToken,
    required String refreshToken,
    int expiresIn = 3600,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
  }

  /// Clear tokens (logout)
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    _tokenExpiry = null;
  }

  /// Update access token (for refresh)
  void updateAccessToken(String accessToken, int expiresIn) {
    _accessToken = accessToken;
    _tokenExpiry = DateTime.now().add(Duration(seconds: expiresIn));
  }
}
