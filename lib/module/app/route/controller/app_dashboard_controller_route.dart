import '../../../../directory/route_directory.dart';

class AppDashboardControllerRoute {
  const AppDashboardControllerRoute();

  void viewSettings() async {
    RouteDirectory.user.navigator.setting();
  }
}
