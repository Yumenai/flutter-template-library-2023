import '../data/app_data.dart';
import '../data/variable/environment_variable_data.dart';
import 'repository/key_repository_service.dart';
import 'repository/network_repository_service.dart';

class RepositoryService {
  static const key = KeyRepositoryService();

  static final network = NetworkRepositoryService(
    getHostAddress:() {
      if (AppData.isDevelopmentMode) {
        switch(RepositoryService.key.appEnvironmentData) {
          case EnvironmentVariableData.production:
            return AppData.hostAddressProduction;
          case EnvironmentVariableData.userAcceptanceTest:
            return AppData.hostAddressUserAcceptanceTest;
          case EnvironmentVariableData.systemIntegrationTest:
            return AppData.hostAddressSystemIntegrationTest;
          case EnvironmentVariableData.development:
          default:
            return AppData.hostAddressDevelopment;
        }
      } else {
        return AppData.hostAddressProduction;
      }
    },
    getAccessToken: () => RepositoryService.key.sessionAccessToken,
    getRefreshToken: () => RepositoryService.key.sessionRefreshToken,
  );

  static Future<void> clear() async {
    await key.clear();
  }

  const RepositoryService._();
}
