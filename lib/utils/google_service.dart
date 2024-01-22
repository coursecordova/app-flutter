import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_cordova/component/alert.dart';
import 'package:flutter_application_cordova/utils/data.dart';
import 'package:flutter_application_cordova/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleService {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
    'email',
    // 'https://www.googleapis.com/auth/contacts.readonly',
  ],
  );

  googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken, idToken: gAuth.idToken);

    final UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final User? userData = user.user;

    print("=========================");
    print(userData!.email);
    print(userData.displayName);

    if (await _googleSignIn.isSignedIn()) {
      bool isLogin = await signupWithGoogle(
          email: userData.email,
          emailId: userData.uid,
          displayName: userData.displayName);

      if (isLogin) {
        AlertSystem.successAlert(context, page: "/home");
      }

      Userpref.setIsLogin(true);
    }

    
  }

  googleLogout() async {
    try {
      await _googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      print("user logout");
    } catch (e) {
      print("Logout Error: $e");
    }
  }
}
