import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_cabi_app/modules/auth/controllers/auth_controller.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class LoginView extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    // Get.lazyPut(() => AuthProvider());
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Login View'),
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
              OutlinedButton.icon(
                onPressed: () {
                  authController.onLogin(emailCtrl.text, passCtrl.text);
                  // Get.toNamed(AppRoutes.tournament);
                },
                label: const Text('Iniciar sesión'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Column(
                      children: [
                        Text('Si no tienes una cuenta'),
                        Text(' puedes registrarte aquí'),
                      ],
                    ),
                  ),
                  IconButton.outlined(
                    onPressed: () {
                      Get.toNamed(AppRoutes.register);
                    },
                    icon: const Icon(Icons.grade),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
