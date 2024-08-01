import 'package:flutter/material.dart';
import '/models/player.dart';
import 'package:intl/intl.dart';

class CardItemPlayer extends StatelessWidget {
  final Player player;
  const CardItemPlayer({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: GestureDetector(
        onTap: () {
          // Acción al tocar la tarjeta, si es necesario
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Container(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '${player.firstName} ${player.lastName}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Número: ${player.playerNumber}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Teléfono: ${player.phone}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Email: ${player.email}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Género: ${player.gender}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Fecha de Nacimiento: ${DateFormat('dd/MM/yyyy').format(player.birthdate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Estado: ${player.status}',
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
