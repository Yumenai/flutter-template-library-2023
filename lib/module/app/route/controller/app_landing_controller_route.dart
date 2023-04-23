class AppLandingControllerRoute {
  final void Function() onSignIn;
  final void Function() onSignUp;

  const AppLandingControllerRoute({
    required this.onSignIn,
    required this.onSignUp,
  });
}
