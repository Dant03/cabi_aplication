import 'package:flutter/material.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Game View'),
            IconButton.outlined(
              onPressed: () {},
              icon: const Icon(Icons.sd),
            )
          ],
        ),
      ),
    );
  }
}