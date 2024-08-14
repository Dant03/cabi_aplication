import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/models/login_request_model.dart';
import 'package:movil_cabi_app/modules/auth/provider/auth_provider.dart';

import 'package:movil_cabi_app/routes/app_routes.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Inicio de sesión',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 120),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: const InputDecoration(
                      label: Text('Contraseña'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.5),
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      ref.read(
                        AuthProvider.postLoginProvider(
                          LoginRequestModel(
                            email: emailCtrl.text,
                            password: passCtrl.text,
                          ),
                        ),
                      );
                      // if (await ref.read(AuthProvider.isAuthenticated)) {
                      //   Get.offAllNamed(AppRoutes.tournament);
                      // } else {
                      //   Get.snackbar('Error', 'Error en la autenticación');
                      // }
                    },
                    label: const Text('Iniciar sesión'),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.register),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Column(
                          children: [
                            Text('Si no tienes una cuenta'),
                            Text(
                              ' puedes registrarte aquí',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
