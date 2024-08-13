import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/provider/auth_provider.dart';
import 'package:movil_cabi_app/modules/players/models/player_model.dart';
import 'package:movil_cabi_app/modules/players/providers/player_provider.dart';
import 'package:movil_cabi_app/modules/players/widgets/birdthday_picker_widget.dart';

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

    final userId = ref.watch(AuthProvider.userAuth)?.userId;
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
                        BirdthdayPickerWidget(birdthdayCtrl: birthDayCtrl),
                        const SizedBox(height: 15),
                        TextField(
                          controller: genderCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Género',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () async {
                            print("boton presionado");
                            final dateSplit = birthDayCtrl.text.split('-');
                            print(dateSplit);
                            final playerSubmit = PlayerModel(
                              userId: userId,
                              playerDni: dniCtrl.text,
                              playerPhone: phoneCtrl.text,
                              playerGender: genderCtrl.text,
                              playerBirthdate: DateTime.utc(
                                int.parse(dateSplit[0]),
                                int.parse(dateSplit[1]),
                                int.parse(dateSplit[2]),
                              ),
                            );
                            print(playerSubmit.toJson());
                            ref.read(
                              PlayerProvider.postPlayerProfile(playerSubmit),
                            );
                          },
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
