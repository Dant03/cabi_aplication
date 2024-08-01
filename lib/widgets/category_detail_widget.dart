import 'package:flutter/material.dart';
import '/models/category.dart';

class CategoryDetailWidget extends StatelessWidget {
  final Category category;

  const CategoryDetailWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nombre: ${category.name}',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Mínimo de Equipos: ${category.minTeams}'),
          Text('Máximo de Equipos: ${category.maxTeams}'),
          Text('Modalidades: ${category.modalities.join(', ')}'),
          Text('Género Permitido: ${category.allowedGender}'),
          Text('Edad Máxima: ${category.maxAge}'),
          Text('Edad Mínima: ${category.minAge}'),
          Text('Estado: ${category.status}'),
        ],
      ),
    );
  }
}
