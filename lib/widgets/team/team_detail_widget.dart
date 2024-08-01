import 'package:flutter/material.dart';
import '/models/team.dart';

class TeamDetailWidget extends StatelessWidget {
  final Team team;

  const TeamDetailWidget({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Image.network(team.logo.toString()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                team.name!,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
            'Nombre: ${team.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Capitán: ${team.captain}'),
          Text('Teléfono: ${team.phone}'),
          Text('Email: ${team.email}'),
          Text('Categoría ID: ${team.categoryId}'),
          Text('Jugadores: ${team.players?.join(', ')}'),
          Text('Estado: ${team.status}'),
          Text('Usuario ID: ${team.userId}'),
        ],
      ),
    );
  }
}
