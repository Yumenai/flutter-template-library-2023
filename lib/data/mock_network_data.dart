class MockNetworkData {
  static Future<void> mockLoading() => Future.delayed(const Duration(seconds: 1));

  static final userList = [
    formatUser(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@gmail.com',
      authenticateId: 'johndoe@gmail.com',
      authenticatePassword: '1234',
      refreshToken: '1234',
      accessToken: '1234',
      avatarImageUrl: 'https://images.unsplash.com/photo-1522383225653-ed111181a951',
      birthdate: DateTime(1997, 8, 27),
    ),
  ];

  static Map formatUser({
    required final String id,
    required final String name,
    required final String email,
    required final String authenticateId,
    required final String authenticatePassword,
    required final String refreshToken,
    required final String accessToken,
    required final String avatarImageUrl,
    required final DateTime? birthdate,
  }) {
    return {
      'id': id,
      'name': name,
      'email': email,
      'authenticate_id': authenticateId,
      'authenticate_password': authenticatePassword,
      'session_refresh_token': refreshToken,
      'session_access_token': accessToken,
      'avatar_image_url': avatarImageUrl,
      'birthdate': birthdate?.toIso8601String(),
    };
  }

  const MockNetworkData._();
}