class AuthenticationLoginModel {
  static AuthenticationLoginModel? fromJson(final Map? json) {
    if (json == null) return null;

    return AuthenticationLoginModel(
      refreshToken: json['session_refresh_token']?.toString() ?? '',
    );
  }

  final String refreshToken;

  const AuthenticationLoginModel({
    required this.refreshToken,
  });
}
