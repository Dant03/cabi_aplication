import 'package:flutter/material.dart';

class GameCardWidget extends StatelessWidget {
  const GameCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: double.infinity,
          child: Column(
            children: [
              const Text('Partidos'),
              const Text('Torneo'),
              const Text('Categoria'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: 125,
                    height: 125,
                    color: Colors.red,
                    child: const Center(child: Text('Equipo A'),),
                  ),
                  Container(
                    width: 125,
                    height: 125,
                    color: Colors.blue,
                    child: const Center(child: Text('Equipo B'),),
                  ),
                ],
              ),
              const Text('Fecha'),
              const Text('Ubicación'),
            ],
          ),
        ),
      ),
    );
  }
}
