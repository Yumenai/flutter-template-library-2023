import '../../../utility/storage/key_storage_utility.dart';

const _accessTokenKey = 'access-token';

class KeyStorageRepositoryService {
  const KeyStorageRepositoryService();

  Future<String> get accessToken async {
    return await KeyStorageUtility.getString(_accessTokenKey) ?? '';
  }

  Future<void> setAccessToken(final String? accessToken) async {
    await KeyStorageUtility.setString(_accessTokenKey, accessToken ?? '');
  }

  Future<void> clear() async {
    await KeyStorageUtility.clear();
  }
}