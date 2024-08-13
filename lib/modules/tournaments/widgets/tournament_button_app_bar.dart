import 'package:flutter/material.dart';

class TournamentButtonAppBar extends StatelessWidget {
  const TournamentButtonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.military_tech),
              ),
              const Text(
                'Torneos en juego',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          Column(
            children: [
              IconButton.outlined(
                onPressed: () {},
                icon: const Icon(Icons.history_edu_outlined),
              ),
              const Text(
                'Todos los torneos',
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
  }
}
