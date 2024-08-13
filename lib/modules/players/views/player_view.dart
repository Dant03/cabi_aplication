import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/drawer_widget.dart';
import '../../auth/provider/auth_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/no_player_profile_widget.dart';

class PlayerView extends ConsumerWidget {
  const PlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProv = ref.watch(AuthProvider.userAuth);
    final playerProd = ref.watch(
      PlayerProvider.getPlayerProfileByUserId(userProv?.userId),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de jugador'),
      ),
      drawer: DrawerWidget(),
      body: playerProd.when(
        data: (profile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Cedula de Identidad: ${profile.playerDni}'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Teléfono/celular: ${profile.playerPhone}'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text('Género: ${profile.playerGender}'),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                    'Fecha de nacimiento: ${profile.playerBirthdate.toString().split(' ')[0]}'),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Actualizar'),
                  ),
                ),
              )
            ],
          );
        },
        error: (obj, str) => const Center(
          child: NoPlayerProfileWidget(),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
