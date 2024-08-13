import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/drawer_widget.dart';
import '../providers/tournament_provider.dart';
import '../widgets/tournament_detail_widget.dart';

class TournamentView extends ConsumerWidget {
  const TournamentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentProv = ref.watch(TournamentProvider.getTournamentsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
      // bottomNavigationBar: const TournamentButtonAppBar(),
      drawer: DrawerWidget(),
      body: tournamentProv.when(
        data: (ts) => SingleChildScrollView(
          child: Column(
              children: ts
                  .map((t) => TournamentDetailWidget(tournament: t))
                  .toList()),
        ),
        error: (obj, stc) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(obj.toString()), Text(stc.toString())],
          ),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
