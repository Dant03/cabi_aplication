import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import '/providers/team_provider.dart';
// import '/routes/app_routes.dart';
import '/models/team.dart';
import '/widgets/custom_input_text.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';

class CreateTeamScreen extends ConsumerWidget {
  final String? teamId;
  const CreateTeamScreen({super.key, this.teamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController logoCtrl = TextEditingController();
    final TextEditingController captainCtrl = TextEditingController();
    final TextEditingController phoneCtrl = TextEditingController();
    final TextEditingController emailCtrl = TextEditingController();
    final TextEditingController categoryIdCtrl = TextEditingController();
    final TextEditingController playersCtrl = TextEditingController();
    final TextEditingController statusCtrl = TextEditingController();
    final TextEditingController userIdCtrl = TextEditingController();

    final teamIdProv = teamId == null
        ? ref.watch(teamEmptyProvider)
        : ref.watch(teamByIdProvider(teamId!));

    return Scaffold(
      appBar: AppBar(
        title: teamId == null
            ? const Text("Crear Equipo")
            : const Text("Actualizar Equipo"),
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
                    teamIdProv.when(
                      data: (team) {
                        if (teamId != null) {
                          // Update inputs controllers
                          nameCtrl.text = team.name ?? '';
                          logoCtrl.text = team.logo ?? '';
                          captainCtrl.text = team.captain ?? '';
                          phoneCtrl.text = team.phone ?? '';
                          emailCtrl.text = team.email ?? '';
                          categoryIdCtrl.text = team.categoryId.toString();
                          playersCtrl.text = team.players == null
                              ? ''
                              : team.players!.join(', ');
                          statusCtrl.text = team.status ?? '';
                          userIdCtrl.text = team.userId.toString();
                        }
                        return Column(
                          children: [
                            const Text("Nombre Equipo"),
                            CustomInputText(
                              label: 'Nombre Equipo',
                              hintText: 'Indique el nombre del equipo',
                              controller: nameCtrl,
                            ),
                            const Text("Logo"),
                            CustomInputText(
                              label: 'Logo',
                              hintText: 'URL del logo',
                              controller: logoCtrl,
                            ),
                            const Text("Capitán"),
                            CustomInputText(
                              label: 'Capitán',
                              hintText: 'Nombre del capitán',
                              controller: captainCtrl,
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
                            const Text("Categoría ID"),
                            CustomInputText(
                              label: 'Categoría ID',
                              hintText: 'ID de la categoría',
                              controller: categoryIdCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Jugadores"),
                            CustomInputText(
                              label: 'Jugadores',
                              hintText: 'Nombres de los jugadores separados por comas',
                              controller: playersCtrl,
                            ),                            
                            const Text("Usuario ID"),
                            CustomInputText(
                              label: 'Usuario ID',
                              hintText: 'ID del usuario',
                              controller: userIdCtrl,
                              keyboardType: TextInputType.number,
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
                          final Team teamSubmit = Team(
                            name: nameCtrl.text,
                            logo: logoCtrl.text,
                            captain: captainCtrl.text,
                            phone: phoneCtrl.text,
                            email: emailCtrl.text,
                            categoryId: int.tryParse(categoryIdCtrl.text) ?? 0,
                            players: playersCtrl.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                            status: statusCtrl.text,
                            userId: int.tryParse(userIdCtrl.text) ?? 0,
                          );
                          print(teamSubmit.toJson());
                          if (teamId == null) {
                            // Crear
                            ref.read(createTeamProvider(teamSubmit).future);
                          } else {
                            // Actualizar
                            ref.read(updateTeamProvider(teamSubmit).future);
                          }

                          //context.push(AppRoutes.teamScreen);
                          //ref.invalidate(getTeamsProvider);
                        },
                        child: Text(
                          teamId == null ? 'Crear' : 'Actualizar',
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
