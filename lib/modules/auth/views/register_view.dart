import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/models/register_request_model.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

import '../provider/auth_provider.dart';

class RegisterView extends ConsumerWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameCtrl = TextEditingController();
    final lastNameCtrl = TextEditingController();
    final emailCtrl = TextEditingController();
    final passCtrl = TextEditingController();
    final passRepCtrl = TextEditingController();
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Registro: nuevo usuario',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                  
                  const SizedBox(height: 80),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: firstNameCtrl,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text('Nombres'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: lastNameCtrl,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        label: Text('Apellidos'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextField(
                      controller: passRepCtrl,
                      obscureText: true,
                      decoration: const InputDecoration(
                        label: Text('Repetir contraseña'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 2.5),
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () async {
            
                        if(passRepCtrl.text != passCtrl.text){
                          Get.snackbar('Error', 'Las contraseñas no coinciden');
                          return;
                        }
            
                        ref.read(
                          AuthProvider.postRegisterProvider(
                            RegisterRequestModel(
                              userFirstName: firstNameCtrl.text,
                              userLastName: lastNameCtrl.text,
                              userEmail: emailCtrl.text,
                              userPassword: passCtrl.text
                            ),
                          ),
                        );
                      },
                      label: const Text('Crear nueva cuenta'),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Get.toNamed(AppRoutes.login),
                        child: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Column(
                            children: [
                              Text('¿Ya tienes una cuenta?'),
                              Text(
                                ' inicia sesión aquí',
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
      ),
    );
  }
}
