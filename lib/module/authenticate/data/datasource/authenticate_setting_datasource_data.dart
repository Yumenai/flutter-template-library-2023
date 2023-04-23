import '../../../../utility/key_value_utility.dart';

const _sessionRefreshTokenKey = 'authenticate_session_refresh_token';

class AuthenticateSettingDatasourceData {
  const AuthenticateSettingDatasourceData();

  Future<String> getSessionRefreshToken() async {
    return await KeyValueUtility.getString(_sessionRefreshTokenKey) ?? '';
  }

  Future<bool> setSessionRefreshToken(final String sessionRefreshToken) {
    return KeyValueUtility.setString(_sessionRefreshTokenKey, sessionRefreshToken);
  }
}
