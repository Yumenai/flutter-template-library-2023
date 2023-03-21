import '../data/configuration_data.dart';
import '../data/environment_data.dart';
import 'repository/key_repository_service.dart';
import 'repository/network_repository_service.dart';

class RepositoryService {
  static const key = KeyRepositoryService();

  static final network = NetworkRepositoryService(
    getHostAddress:() {
      if (ConfigurationData.isDevelopmentMode) {
        switch(RepositoryService.key.appEnvironmentData) {
          case EnvironmentData.production:
            return ConfigurationData.hostAddressProduction;
          case EnvironmentData.userAcceptanceTest:
            return ConfigurationData.hostAddressUserAcceptanceTest;
          case EnvironmentData.systemIntegrationTest:
            return ConfigurationData.hostAddressSystemIntegrationTest;
          case EnvironmentData.development:
          default:
            return ConfigurationData.hostAddressDevelopment;
        }
      } else {
        return ConfigurationData.hostAddressProduction;
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
