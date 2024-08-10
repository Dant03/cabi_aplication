import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class PlayerView extends StatelessWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Player View'),
            IconButton.outlined(
              onPressed: () {
                Get.toNamed(AppRoutes.user);
              },
              icon: const Icon(Icons.handyman_outlined),
            )
          ],
        ),
      ),
    );
  }
}
