import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';
import '/../models/tournament.dart';
import '/../providers/tournament_provider.dart';
import '/../widgets/card_item_tournament.dart';


class TournamentsListScreen extends ConsumerWidget {
  const TournamentsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentProv = ref.watch(getTournamentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Torneos"),
      ),
      drawer: const DrawerWidget(),
      body: tournamentProv.when(
        data: (List<Tournament> tournaments) {
          return SingleChildScrollView(
            child: Column(
              children: tournaments.map((tournament) {
                return CardItemTournament(
                  tournament: tournament,
                );
              }).toList(),
            ),
          );
        },
        error: (obj, err) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $err'),
              const SizedBox(height: 10),
              Text('Details: $obj'),
            ],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
