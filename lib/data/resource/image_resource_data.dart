const _basePath = 'asset/image';

class ImageResourceData {
  final ImageResourceApp app;

  const ImageResourceData.dark() :
        app = const ImageResourceApp.dark();

  const ImageResourceData.light() :
        app = const ImageResourceApp.light();
}

class ImageResourceApp {
  final String logo;
  final String splash;

  const ImageResourceApp.dark() :
        logo = '$_basePath/app-logo.png',
        splash= '$_basePath/app-splash.png';

  const ImageResourceApp.light() :
        logo = '$_basePath/app-logo.png',
        splash= '$_basePath/app-splash.png';
}
