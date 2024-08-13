import 'package:flutter/material.dart';

import '../widgets/game_card_widget.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos los partidos'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // Text('No hay partidos por el momento'),

            // hacer el get de toodos los partidos con join, intentar hacer con categoria
            GameCardWidget(),
            GameCardWidget(),
            GameCardWidget(),
            GameCardWidget(),
          ],
        ),
      ),
    );
  }
}
