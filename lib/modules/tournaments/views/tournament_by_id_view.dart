import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/auth/provider/auth_provider.dart';
import 'package:movil_cabi_app/modules/teams/widgets/team_detail_widget.dart';
import 'package:movil_cabi_app/modules/tournaments/providers/tournament_provider.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class TournamentByIdView extends ConsumerWidget {
  const TournamentByIdView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthProv = ref.watch(AuthProvider.isAuthenticated);
    final idTournament = int.parse('${Get.arguments}');
    final tournametByIdProv =
        ref.watch(TournamentProvider.getTournamentByIdProvider(idTournament));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del torneo"),
      ),
      floatingActionButton: !isAuthProv
          ? FloatingActionButton.extended(
              onPressed: () => Get.offAllNamed(AppRoutes.login),
              label: const Text('Iniciar sesión'),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: tournametByIdProv.when(
          data: (tournament) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeInImage(
                  placeholder: const AssetImage('assets/gifs/loading_1.gif'),
                  image: NetworkImage(tournament.tournamentImageUrl ?? ''),
                  imageErrorBuilder: (c, o, s) =>
                      Image.asset('assets/img/bg-no-photo.jpg'),
                ),
                Text(
                  tournament.tournamentName ?? 'sin-nombre',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ubicación: ${tournament.tournamentLocation}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  "Fecha: ${tournament.tournamentStartDate?.toLocal().toString().split(' ')[0]}",
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Equipos Participantes:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: [
                    if (tournament.teams == null || tournament.teams!.isEmpty)
                      const Text('Aún no hay equipos en el torneo'),
                    if (tournament.teams != null)
                      ...tournament.teams!.map((t) => TeamDetailWidget(t.teamId!))
                  ],
                ),
              ],
            ),
          ),
          error: (obj, str) => Center(child: Text('${obj.toString()}:::${str.toString()}')),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
