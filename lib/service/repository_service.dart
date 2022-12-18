import 'package:template_library/service/repository/storage_repository_service.dart';

class RepositoryService {
  static const storage = StorageRepositoryService();

  static Future<void> clear() async {
    await storage.clear();
  }

  const RepositoryService._();
}