import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationService {
  static Future<String> google() async {
    final response = await GoogleSignIn(
      scopes: [
        'email',
      ],
    ).signIn();

    final googleAuthentication = await response?.authentication;

    return googleAuthentication?.idToken ?? '';
  }


  static Future<String> apple() async {
    final response = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    return response.identityToken ?? '';
  }

  static Future<String> facebook() async {
    final response = await FacebookAuth.instance.login();

    return response.accessToken?.token ?? '';
  }

  const AuthenticationService._();
}