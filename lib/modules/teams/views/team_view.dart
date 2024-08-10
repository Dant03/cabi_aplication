import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';


class TeamView extends StatelessWidget {
  const TeamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Team View'),
            IconButton.outlined(
              onPressed: () {
                Get.toNamed(AppRoutes.player);
              },
              icon: const Icon(Icons.gamepad_outlined),
            )
          ],
        ),
      ),
    );
  }
}