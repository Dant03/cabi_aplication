import 'package:flutter/material.dart';
import 'package:movil_cabi_app/config/cloudinary_config.dart';
import 'package:movil_cabi_app/modules/teams/models/team_model.dart';

class CreateTeamBottomSheet extends StatelessWidget {
  const CreateTeamBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController();
    final logoCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    final emailCtrl = TextEditingController();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Crear nuevo equipo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre del equipo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            // TextField(
            //   controller: phoneCtrl,
            //   decoration: const InputDecoration(
            //     labelText: 'logo - img picker',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const CloudinaryConfig(),
            const SizedBox(height: 15),
            TextField(
              controller: phoneCtrl,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 15),
            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(
                labelText: 'Correo',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final teamSubmit = TeamModel();
                print(teamSubmit.toJson());
              },
              child: const Text('Crear perfil de jugador'),
            ),
          ],
        ),
      ),
    );
  }
}
