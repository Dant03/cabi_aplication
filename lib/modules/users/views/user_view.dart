import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User View'),
            IconButton.outlined(
              onPressed: () {
                Get.toNamed(AppRoutes.welcome);
              },
              icon: const Icon(Icons.ramen_dining_outlined),
            )
          ],
        ),
      ),
    );
  }
}
