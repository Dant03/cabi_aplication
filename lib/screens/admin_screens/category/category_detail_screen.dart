import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/routes/app_routes.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';
import 'package:go_router/go_router.dart';
import '/providers/category_provider.dart';
import '/widgets/category_detail_widget.dart';

class CategoryDetailScreen extends ConsumerWidget {
  final String categoryId;
  const CategoryDetailScreen({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryByIdRef = ref.watch(categoryByIdProvider(categoryId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles Categoría"),
      ),
      floatingActionButton:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            final confirmation = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Confirmación'),
                content: const Text('¿Seguro que quiere eliminar esta categoría?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );

            if (confirmation == true) {
              ref.read(deleteCategoryProvider(categoryId));
              ref.invalidate(getCategoriesProvider);
              context.push(AppRoutes.categoriesScreen);
            }
          },
          child: const Icon(Icons.delete_forever),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
        const SizedBox(width: 16.0), // Espacio entre los botones
        FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            context.push(
              Uri(
                path: AppRoutes.createUpdateCategory,
                queryParameters: {"category_id": categoryId},
              ).toString(),
            );
          },
          child: const Icon(Icons.edit),
          heroTag: null, // Es necesario proporcionar heroTag único o null
        ),
      ]),
      drawer: const DrawerWidget(),
      body: categoryByIdRef.when(
        data: (category) => CategoryDetailWidget(
          category: category,
        ),
        error: (error, stackTrace) => Column(
          children: [
            Text(error.toString()),
            Text(stackTrace.toString()),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
