import '../../../utility/storage/key_storage_utility.dart';

const _refreshTokenKey = 'refresh-token';

class KeyStorageRepositoryService {
  const KeyStorageRepositoryService();

  Future<String> get refreshToken async {
    return await KeyStorageUtility.getString(_refreshTokenKey) ?? '';
  }

  Future<void> setRefreshToken(final String? refreshToken) async {
    await KeyStorageUtility.setString(_refreshTokenKey, refreshToken ?? '');
  }

  Future<void> clear() async {
    await KeyStorageUtility.clear();
  }
}