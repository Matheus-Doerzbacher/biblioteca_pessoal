import 'package:biblioteca_pessoal/layers/presentation/controllers/user_controller.dart';
import 'package:biblioteca_pessoal/layers/presentation/ui/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

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
                        )
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
                                    final user =
                                        await UserController.loginWithGoogle();

                                    if (user != null && context.mounted) {
                                      Navigator.of(context)
                                          .pushReplacementNamed('/');
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
                                  } finally {
                                    setState(() {
                                      _isLoading = false; // Stop loading
                                    });
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
