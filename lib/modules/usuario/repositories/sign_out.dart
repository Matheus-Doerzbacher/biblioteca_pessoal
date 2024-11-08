import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignOut {
  Future<void> call() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
