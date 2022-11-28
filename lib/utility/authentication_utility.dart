import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationUtility {
  static Future<String> google() async {
    final googleResponse = await GoogleSignIn(
      scopes: [
        'email',
      ],
    ).signIn();

    final googleAuthentication = await googleResponse?.authentication;

    return googleAuthentication?.idToken ?? '';
  }


  static Future<String> apple() async {
    final appleResponse = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    return appleResponse.identityToken ?? '';
  }

  static Future<String> facebook() async {
    final facebookResponse = await FacebookAuth.instance.login();

    return facebookResponse.accessToken?.token ?? '';
  }

  const AuthenticationUtility._();
}