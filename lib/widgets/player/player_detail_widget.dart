import 'package:flutter/material.dart';
import '/models/player.dart';
import 'package:intl/intl.dart';

class PlayerDetailWidget extends StatelessWidget {
  final Player player;

  const PlayerDetailWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre: ${player.firstName} ${player.lastName}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Número: ${player.playerNumber}'),
          Text('Teléfono: ${player.phone}'),
          Text('Email: ${player.email}'),
          Text('Género: ${player.gender}'),
          Text('Fecha de Nacimiento: ${DateFormat('dd/MM/yyyy').format(player.birthdate!)}'),
          Text('Estado: ${player.status}'),
        ],
      ),
    );
  }
}
