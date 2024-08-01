import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '/providers/player_provider.dart';
import '/routes/app_routes.dart';
import '/models/player.dart';
import '/widgets/custom_input_text.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';

class CreatePlayerScreen extends ConsumerWidget {
  final String? playerId;
  const CreatePlayerScreen({super.key, this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController firstNameCtrl = TextEditingController();
    final TextEditingController lastNameCtrl = TextEditingController();
    final TextEditingController playerNumberCtrl = TextEditingController();
    final TextEditingController phoneCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController genderCtrl = TextEditingController();
    final TextEditingController birthdateCtrl = TextEditingController();
    final TextEditingController statusCtrl = TextEditingController();

    final playerIdProv = playerId == null
        ? ref.watch(playerEmptyProvider)
        : ref.watch(playerByIdProvider(playerId!));

    return Scaffold(
      appBar: AppBar(
        title: playerId == null
            ? const Text("Crear Jugador")
            : const Text("Actualizar Jugador"),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    playerIdProv.when(
                      data: (player) {
                        if (playerId != null) {
                          // Update inputs controllers
                          firstNameCtrl.text = player.firstName;
                          lastNameCtrl.text = player.lastName;
                          playerNumberCtrl.text = player.playerNumber.toString();
                          phoneCtrl.text = player.phone;
                          emailCtrl.text = player.email;
                          genderCtrl.text = player.gender;
                          birthdateCtrl.text = DateFormat('yyyy-MM-dd').format(player.birthdate);
                          statusCtrl.text = player.status;
                        }
                        return Column(
                          children: [
                            const Text("Nombre del Jugador"),
                            CustomInputText(
                              label: 'Nombre',
                              hintText: 'Indique el nombre',
                              controller: firstNameCtrl,
                            ),
                            const Text("Apellido"),
                            CustomInputText(
                              label: 'Apellido',
                              hintText: 'Indique el apellido',
                              controller: lastNameCtrl,
                            ),
                            const Text("Número de Jugador"),
                            CustomInputText(
                              label: 'Número de Jugador',
                              hintText: 'Número del jugador',
                              controller: playerNumberCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Teléfono"),
                            CustomInputText(
                              label: 'Teléfono',
                              hintText: 'Número de teléfono',
                              controller: phoneCtrl,
                              keyboardType: TextInputType.phone,
                            ),
                            const Text("Email"),
                            CustomInputText(
                              label: 'Email',
                              hintText: 'Correo electrónico',
                              controller: emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const Text("Género"),
                            CustomInputText(
                              label: 'Género',
                              hintText: 'Género',
                              controller: genderCtrl,
                            ),
                            const Text("Fecha de Nacimiento"),
                            CustomInputText(
                              label: 'Fecha de Nacimiento',
                              hintText: 'Fecha de nacimiento',
                              controller: birthdateCtrl,
                              keyboardType: TextInputType.datetime,
                            ),
                            const Text("Estado"),
                            CustomInputText(
                              label: 'Estado',
                              hintText: 'Estado del jugador',
                              controller: statusCtrl,
                            ),
                          ],
                        );
                      },
                      error: (err, trc) {
                        return Column(
                          children: [Text('$err'), Text('$trc')],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          final Player playerSubmit = Player(
                            firstName: firstNameCtrl.text,
                            lastName: lastNameCtrl.text,
                            playerNumber: int.tryParse(playerNumberCtrl.text) ?? 0,
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            gender: genderCtrl.text,
                            birthdate: DateFormat('yyyy-MM-dd').parse(birthdateCtrl.text),
                            status: statusCtrl.text,
                          );
                          print(playerSubmit.toJson());
                          if (playerId == null) {
                            // Crear
                            ref.read(createPlayerProvider(playerSubmit).future);
                          } else {
                            // Actualizar
                            ref.read(updatePlayerProvider(playerSubmit).future);
                          }

                          //context.push(AppRoutes.playerScreen);
                          //ref.invalidate(getPlayersProvider);
                        },
                        child: Text(
                          playerId == null ? 'Crear' : 'Actualizar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
