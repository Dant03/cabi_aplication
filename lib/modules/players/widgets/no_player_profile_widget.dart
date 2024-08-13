import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class NoPlayerProfileWidget extends ConsumerWidget {
  const NoPlayerProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    

    final dniCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final genderCtrl = TextEditingController();
    final birthDayCtrl = TextEditingController();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No tiene creado un perfil de jugador'),
          OutlinedButton.icon(
            onPressed: () {
              Get.bottomSheet(Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Crear perfil de jugador',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: dniCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Documento de identificación',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: phoneCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono/celular',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: genderCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Género',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 15),
                        TextField(
                          controller: birthDayCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Fecha Nacimiento',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Crear perfil de jugador'),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
            },
            label: const Text('Crear perfil de jugador'),
          )
        ],
      ),
    );
  }
}
