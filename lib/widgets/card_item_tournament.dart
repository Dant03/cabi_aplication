import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cabi_app/routes/app_routes.dart';
import 'package:cabi_app/models/tournament.dart';
import 'package:intl/intl.dart';

class CardItemTournament extends StatelessWidget {
  final Tournament tournament;
  const CardItemTournament({
    super.key,
    required this.tournament,
  });

  


  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () => context.push(Uri(path: AppRoutes.tournamentDetail,queryParameters: {"tournament_id": '${tournament.tournamentId}'}).toString()),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  tournament.image!,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Center(
                    child: Icon(Icons.error),
                  ),
                ),
                GestureDetector(
                  onTap: () => context.go('${AppRoutes.tournamentDetail}/${tournament.tournamentId}'),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          tournament.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          tournament.location!,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Categorias: ${tournament.categories!.join(', ')}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Fecha Inicio: ${tournament.startDate != null ? DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse(tournament.startDate!)) : 'Fecha no disponible'}',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
