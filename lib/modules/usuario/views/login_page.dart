import 'package:biblioteca_pessoal/core/routes/app_routes.dart';
import 'package:biblioteca_pessoal/modules/usuario/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final controller = GetIt.I<UserController>();

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset('assets/images/login.svg'),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    textScaler: MediaQuery.of(context).textScaler,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Minha',
                          style: TextStyle(
                            color: colorSchema.onSurface,
                          ),
                        ),
                        TextSpan(
                          text: 'Biblioteca',
                          style: TextStyle(
                            color: colorSchema.primary,
                          ),
                        ),
                      ],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _isLoading
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });

                                  try {
                                    await controller.loginWithGoogle();

                                    if (context.mounted) {
                                      await Navigator.of(context)
                                          .pushReplacementNamed(AppRoutes.home);
                                    }
                                  } on FirebaseAuthException catch (error) {
                                    if (kDebugMode) {
                                      print(error.message);
                                    }
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            error.message ??
                                                'Erro não esperado',
                                          ),
                                        ),
                                      );
                                    }
                                  } catch (error) {
                                    if (kDebugMode) {
                                      print(error);
                                    }
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(error.toString()),
                                        ),
                                      );
                                    }
                                  }
                                },
                          label: _isLoading
                              ? SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      colorSchema.onPrimary,
                                    ),
                                  ),
                                )
                              : const Text('Logar com Google'),
                          icon: const Icon(
                            Icons.g_mobiledata,
                            size: 35,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorSchema.primary,
                            foregroundColor: colorSchema.onPrimary,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
