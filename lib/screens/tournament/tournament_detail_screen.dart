import 'package:cabi_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';
import 'package:go_router/go_router.dart';
import '/../providers/tournament_provider.dart';
import '/../widgets/tournament_detail_widget.dart';

class TournamentDetailScreen extends ConsumerWidget {
  final String tournamentId;
  const TournamentDetailScreen({super.key, required this.tournamentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentByIdRef = ref.watch(tournamentByIdProvider(tournamentId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles Torneo"),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmacion'),
                content: const Text('Seguro que quiere eliminar este torneo?'),
                actions: [
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).pop(false),
                    },
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => {
                      Navigator.of(context).pop(true),
                      //final tournamentId = "1"; // Id del torneo a eliminar
                      ref.read(deleteTournamentProvider(tournamentId)),
                      ref.invalidate(getTournamentsProvider),

                      // print(result);
                      context.push(AppRoutes.tournamentsScreen)
                    },
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );
          },

          // },
          child: Icon(Icons.delete_forever),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
        SizedBox(width: 16.0), // Espacio entre los botones
        FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            context.push(Uri(
                path: AppRoutes.createUpdateTournament, 
                queryParameters: { "tournament_id": '${ref.watch(tournamentByIdProvider(tournamentId))}'
                }).toString());

            //context.push(AppRoutes.createUpdate);
          },
          child: Icon(Icons.edit),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
      ]),
      drawer: const DrawerWidget(),
      body: tournamentByIdRef.when(
        data: (tournament) => TournamentDetailWidget(
          tournament: tournament,
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
