/// Token response model from API
class TokenResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;

  const TokenResponse({
    required this.accessToken,
    required this.refreshToken,
    this.tokenType = 'Bearer',
    required this.expiresIn,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      tokenType: json['token_type'] ?? 'Bearer',
      expiresIn: json['expires_in'] ?? 3600,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
    };
  }
}
