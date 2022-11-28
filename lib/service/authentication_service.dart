import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthenticationService {
  const AuthenticationService();

  Future<String?> google() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );

    final authenticationResponse = await googleSignIn.signIn();
    final authenticationGoogleResponse = await authenticationResponse?.authentication;
    return authenticationGoogleResponse?.idToken;
  }


  Future<String?> apple() async {
    final appleResponse = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    return appleResponse.identityToken;
  }

  Future<String?> facebook() async {
    final facebookResponse = await FacebookAuth.instance.login();

    return facebookResponse.accessToken?.token;
  }
}