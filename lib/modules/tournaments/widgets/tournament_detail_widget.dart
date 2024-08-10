import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/modules/tournaments/models/tournament_model.dart';

class TournamentDetailWidget extends StatelessWidget {
  final TournamentModel tournament;
  const TournamentDetailWidget({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(tournament.tournamentName ?? ''),
          Text(tournament.tournamentEmail ?? ''),
          Text(tournament.tournamentStartDate.toString()),
          Text(tournament.tournamentName ?? ''),
        ],
      ),
    ));
  }
}
