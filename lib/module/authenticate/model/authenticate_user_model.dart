class AuthenticateUserModel {
  static AuthenticateUserModel? fromJson(final Map? json) {
    if (json == null) return null;

    return AuthenticateUserModel(
      refreshToken: json['data']?['session_refresh_token']?.toString() ?? '',
    );
  }

  final String refreshToken;

  const AuthenticateUserModel({
    required this.refreshToken,
  });
}
