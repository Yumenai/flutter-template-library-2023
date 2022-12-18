import 'storage/key_storage_repository_service.dart';

class StorageRepositoryService {
  const StorageRepositoryService();

  final key = const KeyStorageRepositoryService();

  Future<void> clear() async {
    await key.clear();
  }
}
