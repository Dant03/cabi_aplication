import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movil_cabi_app/modules/tournaments/providers/tournament_provider.dart';
import 'package:movil_cabi_app/modules/tournaments/widgets/tournament_button_app_bar.dart';
import 'package:movil_cabi_app/modules/tournaments/widgets/tournament_detail_widget.dart';

import 'package:movil_cabi_app/shared/widgets/drawer_widget.dart';

class TournamentView extends ConsumerWidget {
  const TournamentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tournamentProv = ref.watch(TournamentProvider.getTournamentsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torneos'),
      ),
      bottomNavigationBar: const TournamentButtonAppBar(),
      drawer: DrawerWidget(),
      body: tournamentProv.when(
        data: (ts) => SingleChildScrollView(
          child: Column(
            children: ts != null
                ? ts.map((t) => TournamentDetailWidget(tournament: t)).toList()
                : [],
          ),
        ),
        error: (obj, stc) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(obj.toString()),
              Text(stc.toString()),
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
