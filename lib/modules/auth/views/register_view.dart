import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Register View'),
            IconButton.outlined(
              onPressed: () {
                Get.toNamed(AppRoutes.tournament);
              },
              icon: const Icon(Icons.person_outline),
            )
          ],
        ),
      ),
    );
  }
}
