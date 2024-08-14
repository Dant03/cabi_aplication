import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/provider/auth_provider.dart';
import 'package:movil_cabi_app/modules/players/providers/player_provider.dart';
import 'package:movil_cabi_app/modules/teams/providers/teams_provider.dart';
import 'package:movil_cabi_app/modules/teams/widgets/create_team_bottom_sheet.dart';
import 'package:movil_cabi_app/shared/widgets/drawer_widget.dart';

class TeamsOwnedView extends ConsumerWidget {
  const TeamsOwnedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerProv = ref.watch(PlayerProvider.playerProvider);
    final teamPlayerRelProv = ref.watch(TeamsProvider.getTeamsByPlayerIdProvider(playerProv.playerId ?? 0));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos del usuario'),
      ),
      drawer: DrawerWidget(),
      floatingActionButton: teamPlayerRelProv.when(
          data: (p) => FloatingActionButton.extended(
                onPressed: () {
                  Get.bottomSheet(const CreateTeamBottomSheet());
                },
                label: const Text('Crear Equipo'),
              ),
          error: (obj, s) => const Placeholder(),
          loading: () => const Placeholder()),
      body: teamPlayerRelProv.when(
        data: (tpr) => Column(children: tpr.map((t) => Text('-${t.team?.teamName}')).toList(),), 
        error: (obj, str) => const Center(child: Text('No tiene equipos por el momento')), 
        loading: () => const Center(child: CircularProgressIndicator()),
      ),

    );
  }
}
