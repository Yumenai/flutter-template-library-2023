import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view/template/app_template_view.dart';
import 'provider/app_provider.dart';
import 'utility/app_utility.dart';
import 'service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialise();

  final appProvider = await AppProvider().setup();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return appProvider;
          },
        ),
      ],
      child: AppTemplateView(
        name: await AppUtility.name,
        layout: appProvider.startupRoute(),
      ),
    ),
  );
}
