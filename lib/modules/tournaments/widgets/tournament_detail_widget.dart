import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movil_cabi_app/modules/tournaments/models/tournament_model.dart';
import 'package:movil_cabi_app/routes/app_routes.dart';

class TournamentDetailWidget extends StatelessWidget {
  final TournamentModel tournament;
  const TournamentDetailWidget({super.key, required this.tournament});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.tournamentById,
              arguments: tournament.tournamentId),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  tournament.tournamentImageUrl!,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) =>
                      Image.asset('assets/img/bg-no-photo-nbg.jpg'),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                tournament.tournamentName ?? 'sin-nombre',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tournament.tournamentLocation ?? 'sin-locacion',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                tournament.tournamentStartDate!.toLocal().toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
