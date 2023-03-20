import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/template/app_template_component.dart';
import 'controller/app_controller.dart';
import 'route/screen/entry/splash_entry_screen_route.dart';
import 'utility/app_utility.dart';
import 'utility/storage/key_storage_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppUtility.initialise();
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
        name: AppUtility.name,
        layout: const SplashEntryScreenRoute(),
      ),
    ),
  );
}
