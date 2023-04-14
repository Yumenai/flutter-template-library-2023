import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/view/pagination_view_component.dart';
import 'view/template/app_template_view.dart';
import 'provider/app_provider.dart';
import 'directory/repository_directory.dart';
import 'utility/app_utility.dart';
import 'service/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await RepositoryDirectory.initialise();

  await NotificationService.initialise();

  final appController = await AppProvider.initialise();


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return appController;
          },
        ),
      ],
      child: AppTemplateView(
        name: await AppUtility.name,
        layout: Scaffold(
          appBar: AppBar(
            title: Text('Test'),
          ),
          body: PaginationViewComponent.list(
            controller: PaginationViewController(),
            itemBuilder: (context, itemModel) {
              return ListTile(
                title: Text(itemModel.model),
                onTap: () {},
              );
            },
            onLoad: (context, page) async {
              return List.generate(20, (index) => ((index + 1) + (20 * (page - 1))).toString());
            },
          ),
        ),
      ),
    ),
  );
}
