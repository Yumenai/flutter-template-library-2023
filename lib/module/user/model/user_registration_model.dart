class UserRegistrationModel {
  static UserRegistrationModel? fromJson(final Map? json) {
    if (json == null) return null;

    return UserRegistrationModel(
      refreshToken: json['data']?['session_refresh_token']?.toString() ?? '',
    );
  }

  final String refreshToken;

  const UserRegistrationModel({
    required this.refreshToken,
  });
}
