
import 'package:cabi_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:cabi_app/models/category.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CardItemCategory extends StatelessWidget {
  final Category category;
  const CardItemCategory({
    super.key,
    required this.category,
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
          path: AppRoutes.categoryDetail,
          queryParameters: {"category_id": '${category.categoryId}'}).toString()),
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
                        category.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        'Mínimo de Equipos: ${category.minTeams}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Máximo de Equipos: ${category.maxTeams}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Modalidades: ${category.modalities.join(', ')}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Género Permitido: ${category.allowedGender}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Edad Máxima: ${category.maxAge}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Edad Mínima: ${category.minAge}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Estado: ${category.status}',
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
