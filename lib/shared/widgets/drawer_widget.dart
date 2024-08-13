import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/controllers/auth_controller.dart';
import 'package:movil_cabi_app/modules/auth/provider/auth_provider.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class DrawerWidget extends ConsumerWidget {
  final AuthController authController = Get.put(AuthController());
  DrawerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAuthProv = ref.watch(AuthProvider.userAuth);
    return Drawer(
      child: SafeArea(
        child: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Icon(
                        Icons.person_2_outlined,
                        size: 80,
                        color: Colors.orangeAccent,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black26,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Usuario autenticado',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text('Nombres: ${userAuthProv?.userFirstName}'),
                          Text('Apellidos: ${userAuthProv?.userLastName}'),
                          Text('Correo: ${userAuthProv?.userEmail}'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 300,
                      child: ListView(
                        children: [
                          ListTile(
                            trailing: const Icon(Icons.arrow_right_alt_outlined),
                            title: const Text('Torneos'),
                            onTap: () => Get.toNamed(AppRoutes.tournament),
                          ),
                          ListTile(
                            trailing: const Icon(Icons.sports_basketball_outlined),
                            title: const Text('Partidos'),
                            onTap: () => Get.toNamed(AppRoutes.game),
                          ),
                          ListTile(
                            trailing: const Icon(Icons.person_add_alt_outlined),
                            title: const Text('Perfil de jugador'),
                            onTap: () => Get.toNamed(AppRoutes.player),
                          ),
                          ListTile(
                            trailing: const Icon(Icons.api_outlined),
                            title: const Text('Sus equipos'),
                            onTap: () => Get.toNamed(AppRoutes.teamUser),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
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
        ),
      ),
    );
  }
}
