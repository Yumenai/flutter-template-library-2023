import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/template/app_template_component.dart';
import 'controller/app_controller.dart';
import 'route/access_route.dart';
import 'service/app_service.dart';
import 'utility/storage/key_storage_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppService.initialise();
  await KeyStorageUtility.initialise();

  final appController = await AppController.initialise();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return appController;
          },
        ),
      ],
      child: AppTemplateComponent(
        name: AppService.instance?.name ?? '',
        layout: AccessRoute.screen.splash,
      ),
    ),
  );
}
