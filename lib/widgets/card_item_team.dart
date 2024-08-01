import 'package:cabi_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '/models/team.dart';

class CardItemTeam extends StatelessWidget {
  final Team team;
  const CardItemTeam({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () => context.push(Uri(
          path: AppRoutes.teamDetail,
          queryParameters: {"team_id": '${team.teamId}'}).toString()),
          // Acción al tocar la tarjeta, si es necesario
        
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 120, // Ajusta el alto de la imagen aquí
                    width: 120,  // Ajusta el ancho de la imagen aquí
                    child: Image.network(
                      team.logo!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        team.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Capitán: ${team.captain}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Teléfono: ${team.phone}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Email: ${team.email}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Categoría ID: ${team.categoryId}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Estado: ${team.status}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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
