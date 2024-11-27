import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginWithGoogle {
  Future<User?> call() async {
    try {
      // Tentando logar no Google
      final googleAccount =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();

      if (googleAccount == null) {
        throw Exception('Login cancelado ou falhou');
      }

      final googleAuth = await googleAccount.authentication;

      // Verificando se os tokens são válidos
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Erro ao obter os tokens do Google');
      }

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Autenticando no Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      return userCredential.user;
    } catch (e) {
      throw Exception('Erro ao fazer login com o Google: $e');
    }
  }
}
