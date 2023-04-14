const _basePath = 'asset/image';

enum ImageResourceData {
  dark(
    appLogo: '$_basePath/app-logo.png',
    appSplash: '$_basePath/app-splash.png',
  ),
  light(
    appLogo: '$_basePath/app-logo.png',
    appSplash: '$_basePath/app-splash.png',
  );

  final String appLogo;
  final String appSplash;

  const ImageResourceData({
    required this.appLogo,
    required this.appSplash,
  });
}
