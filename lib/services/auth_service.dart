import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static final _auth = FirebaseAuth.instance;
  static User? get user => _auth.currentUser;
  static Stream<User?> get userStream => _auth.userChanges();
  static bool get isEmailVerified => user?.emailVerified ?? false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String passWord,
  }) async {
    try {
      final credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: passWord)
          .then((credential) {
        credential.user?.sendEmailVerification();
        credential.user?.updateDisplayName(fullName);
      });
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> logIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      rethrow;
    }
  }

  // Đăng nhập bằng google
  static Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser == null) {
      throw const NoGoogleAccountChosenException();
    }
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }

  static Future<void> resetPassword({required String email}) => _auth.sendPasswordResetEmail(email: email);
}

class NoGoogleAccountChosenException implements Exception {
  const NoGoogleAccountChosenException();
}