import 'package:firebase_auth/firebase_auth.dart';

class PasswordlessLoginServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future signInWithEmailandLink(userEmail) async {
    var _userEmail = userEmail;
    return await _auth
        .sendSignInLinkToEmail(
            email: _userEmail,
            actionCodeSettings: ActionCodeSettings(
              url: "https://socializeforvmeg.page.link/MyApp",
              handleCodeInApp: true,
              androidPackageName: "com.example",
              androidMinimumVersion: "1",
            ))
        .then((value) {
      print("email sent");
    });
  }

  void handleLink(Uri link, userEmail) async {
    if (link != null) {
      print(userEmail);
      final UserCredential user =
          await FirebaseAuth.instance.signInWithEmailLink(
        email: userEmail,
        emailLink: link.toString(),
      );
      if (user != null) {
        print(user.credential);
      }
    } else {
      print("link is null");
    }
  }
}
