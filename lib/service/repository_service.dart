import 'repository/memory_repository_service.dart';
import 'repository/network_repository_service.dart';
import 'repository/storage_repository_service.dart';

class RepositoryService {
  static const storage = StorageRepositoryService();

  static final memory = MemoryRepositoryService();

  static final network = NetworkRepositoryService(
    getAccessToken: () => RepositoryService.memory.accessToken,
    getRefreshToken: () => RepositoryService.storage.key.refreshToken,
  );

  static Future<void> clear() async {
    await storage.clear();
    memory.clear();
  }

  const RepositoryService._();
}
