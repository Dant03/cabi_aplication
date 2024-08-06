import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '/providers/player_provider.dart';
import '/routes/app_routes.dart';
import '/models/player.dart';
import '/widgets/custom_input_text.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';

// Define un StateProvider para almacenar el número del jugador
final playerNumberProvider = StateProvider<int>((ref) => 0);

class CreatePlayerScreen extends ConsumerWidget {
  final String? playerId;
  const CreatePlayerScreen({super.key, this.playerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Controladores de texto
    final TextEditingController firstNameCtrl = TextEditingController();
    final TextEditingController lastNameCtrl = TextEditingController();
    final TextEditingController cedulaCtrl = TextEditingController();
    final TextEditingController phoneCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController genderCtrl = TextEditingController();
    final TextEditingController birthdateCtrl = TextEditingController();
    final TextEditingController statusCtrl = TextEditingController();

    final playerIdProv = playerId == null
        ? playerEmptyProvider
        : playerByIdProvider(playerId!);

    final AsyncValue<Player> player = ref.watch(playerIdProv);
    final int playerNumber = ref.watch(playerNumberProvider);

    Future<void> _selectDate(BuildContext context) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (pickedDate != null) {
        birthdateCtrl.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      }
    }

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
                    player.when(
                      data: (playerData) {
                        if (playerId != null) {
                          firstNameCtrl.text = playerData.firstName!;
                          lastNameCtrl.text = playerData.lastName!;
                          cedulaCtrl.text = playerData.cedula!;
                          phoneCtrl.text = playerData.phone!;
                          emailCtrl.text = playerData.email!;
                          genderCtrl.text = playerData.gender!;
                          birthdateCtrl.text = DateFormat('yyyy-MM-dd').format(playerData.birthdate!);
                          // statusCtrl.text = playerData.status!;
                          ref.read(playerNumberProvider.notifier).state = playerData.playerNumber as int;
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
                            const Text("Cedula"),
                            CustomInputText(
                              label: 'Cedula',
                              hintText: 'Ingrese cedula del jugador',
                              controller: cedulaCtrl,
                            ),
                            const Text("Número de Jugador"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    ref.read(playerNumberProvider.notifier).state =
                                        (playerNumber > 0) ? playerNumber - 1 : 99;
                                  },
                                ),
                                Text(
                                  playerNumber.toString().padLeft(2, '0'),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    ref.read(playerNumberProvider.notifier).state =
                                        (playerNumber < 99) ? playerNumber + 1 : 0;
                                  },
                                ),
                                const SizedBox(width: 20),
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/dorsal_jersey.png', // Ruta de la imagen de la camiseta
                                      height: 100,
                                    ),
                                    Text(
                                      playerNumber.toString().padLeft(2, '0'),
                                      style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: CustomInputText(
                                  label: 'Fecha de Nacimiento',
                                  hintText: 'Seleccione la fecha de nacimiento',
                                  controller: birthdateCtrl,
                                ),
                              ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          final Player playerSubmit = Player(
                            firstName: firstNameCtrl.text,
                            lastName: lastNameCtrl.text,
                            cedula: cedulaCtrl.text,
                            playerNumber: playerNumber.toString(),
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            gender: genderCtrl.text,
                            birthdate: DateFormat('yyyy-MM-dd').parse(birthdateCtrl.text),
                            // status: statusCtrl.text,
                          );
                          print(playerSubmit.toJson());
                          if (playerId == null) {
                            // Crear
                            ref.read(createPlayerProvider(playerSubmit).future);
                          } else {
                            // Actualizar
                            ref.read(updatePlayerProvider(playerSubmit).future);
                          }
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
