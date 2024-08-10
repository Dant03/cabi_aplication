import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Te damos la bienvenida a Cabi App'),
            const Text('Continua para iniciar sesión o registrarte'),
            TextButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.login);
              },
              label: const Text('Iniciar sesión'),
              icon: const Icon(Icons.arrow_right_alt_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
