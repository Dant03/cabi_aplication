import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/routes/app_routes.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';
import 'package:go_router/go_router.dart';
import '/providers/team_provider.dart';
import '/widgets/team/team_detail_widget.dart';

class TeamDetailScreen extends ConsumerWidget {
  final String teamId;
  const TeamDetailScreen({super.key, required this.teamId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamByIdRef = ref.watch(teamByIdProvider(teamId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles Equipo"),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            final confirmation = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmación'),
                content: const Text('¿Seguro que quiere eliminar este equipo?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );

            if (confirmation == true) {
              ref.read(deleteTeamProvider(teamId));
              ref.invalidate(getTeamsProvider);
              context.push(AppRoutes.teamScreen);
            }
          },
          child: const Icon(Icons.delete_forever),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
        const SizedBox(width: 16.0), // Espacio entre los botones
        FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            context.push(
              Uri(
                path: AppRoutes.createUpdateTeam,
                queryParameters: {"team_id": teamId},
              ).toString(),
            );
          },
          child: const Icon(Icons.edit),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
      ]),
      drawer: const DrawerWidget(),
      body: teamByIdRef.when(
        data: (team) => TeamDetailWidget(
          team: team,
        ),
        error: (error, stackTrace) => Column(
          children: [
            Text(error.toString()),
            Text(stackTrace.toString()),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
