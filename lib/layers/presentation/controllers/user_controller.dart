// ignore_for_file: avoid_print

import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {
  static User? user = FirebaseAuth.instance.currentUser;

  static bool isLoading = false;

  static Future<User?> loginWithGoogle() async {
    try {
      // Tentando logar no Google
      final googleAccount =
          await GoogleSignIn(scopes: ['profile', 'email']).signIn();

      if (googleAccount == null) {
        print('Login cancelado ou falhou');
        return null;
      }

      final googleAuth = await googleAccount.authentication;

      // Verificando se os tokens são válidos
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        print('Erro ao obter os tokens do Google');
        return null;
      }

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Autenticando no Firebase
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credentials);

      // Atualizando o controlador com o novo usuário
      user = userCredential.user;

      print('Login realizado com sucesso: ${userCredential.user}');
      return userCredential.user;
    } catch (e) {
      print('Erro ao autenticar com o Google: $e');
      return null;
    }
  }

  static Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    user = null;
    if (context.mounted) {
      await Navigator.of(context)
          .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
    }
  }
}
