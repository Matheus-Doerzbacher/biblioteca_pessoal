// ignore_for_file: avoid_print

import 'package:biblioteca_pessoal/modules/usuario/repositories/login_with_google.dart';
import 'package:biblioteca_pessoal/modules/usuario/repositories/sign_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final LoginWithGoogle _loginWithGoogle;
  final SignOut _signOut;

  UserController(this._loginWithGoogle, this._signOut);

  static User? user = FirebaseAuth.instance.currentUser;

  static bool isLoading = false;

  Future<void> loginWithGoogle() async {
    user = await _loginWithGoogle();
    notifyListeners();
  }

  Future<void> signOut() async {
    await _signOut();
    user = null;
    notifyListeners();
  }
}
