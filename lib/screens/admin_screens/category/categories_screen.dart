import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '/providers/category_provider.dart';
import '/routes/app_routes.dart';
import '/widgets/card_item_category.dart';

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesProv = ref.watch(getCategoriesProvider);

    Future<void> onRefresher() async {
      ref.invalidate(getCategoriesProvider);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRoutes.createUpdateCategory);
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: onRefresher,
        child: ListView(
          children: [
            Column(
              children: [
                categoriesProv.when(
                    data: (categories) => Column(
                          children: categories
                              .map((c) => CardItemCategory(category: c))
                              .toList(),
                        ),
                    error: (err, trace) => Column(
                          children: [
                            Text(err.toString()),
                            Text(trace.toString())
                          ],
                        ),
                    loading: () => const CircularProgressIndicator())
              ],
            )
          ],
        ),
      ),
    );
  }
}
