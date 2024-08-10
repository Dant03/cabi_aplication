import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/controllers/auth_controller.dart';

class DrawerWidget extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: OutlinedButton.icon(
                onPressed: () {
                  authController.onLogout();
                },
                icon: const Icon(Icons.door_back_door_outlined),
                label: const Text('Cerrar Sesión'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
