import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/scanner_code_controller_route.dart';
import 'screen/scanner_code_screen_route.dart';

class ScannerDirectoryRoute {
  void initialise() {

  }

  RouteModel<String> get code => RouteModel<String>(
    onBuild: () => ScannerCodeScreenRoute(
      controller: ScannerCodeControllerRoute(),
    ),
    onNavigate: RouteService.push<String>,
  );
}
