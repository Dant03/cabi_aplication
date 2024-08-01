import 'package:cabi_app/providers/tournament_provider.dart';
import 'package:cabi_app/routes/app_routes.dart';
import 'package:cabi_app/widgets/card_item_tournament.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TournamentScreen extends ConsumerWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentsProv = ref.watch(getTournamentsProvider);

    Future<void> onRefresher() async {
      ref.invalidate(getTournamentsProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createUpdateTournament);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresher,
        child: ListView(
          children: [
            Column(
              children: [
                tournamentsProv.when(
                    data: (tournaments) => Column(
                          children: tournaments
                              .map((t) => CardItemTournament(tournament: t))
                              .toList(),
                        ),
                    error: (err, trace) => Column(
                          children: [
                            Text(err.toString()),
                            Text(trace.toString())
                          ],
                        ),
                    loading: () => CircularProgressIndicator())
              ],
            )
          ],
        ),
      ),
    );
  }
}
