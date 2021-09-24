import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

class GoogleSignHelper {
  static GoogleSignHelper _instance = GoogleSignHelper._private();
  GoogleSignHelper._private();

  static GoogleSignHelper get instance => _instance;

  static final GoogleSignIn _googleSign = GoogleSignIn();

  Future<GoogleSignInAccount?> googleSignIn() async {
    final user = await _googleSign.signIn();
    if (user != null) {
      googleAuthenticate();
      return user;
    }
    return null;
  }

  Future<GoogleSignInAuthentication?> googleAuthenticate() async {
    if (await _googleSign.isSignedIn()) {
      final user = await _googleSign.currentUser;
      final userData = await user?.authentication;
      return userData;
    }
    return null;
  }

  Future<GoogleSignInAccount> signOut() async {
    final user = await _googleSign.signOut();
    return user!;
  }

  Future<User> handleSignIn() async {
    final GoogleSignInAuthentication? googleAuth = await googleAuthenticate();
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth!.accessToken,
      idToken: googleAuth.idToken,
    );

    GetStorage().write("googleAccessToken", googleAuth.accessToken);
    GetStorage().write("googleIdToken", googleAuth.idToken);
    final User user = (await auth.signInWithCredential(credential)).user!;
    return user;
  }
}
