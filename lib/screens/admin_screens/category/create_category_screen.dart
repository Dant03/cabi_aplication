import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
import '/providers/category_provider.dart';
// import '/routes/app_routes.dart';
import '/models/category.dart';
import '/widgets/custom_input_text.dart';
import 'package:cabi_app/widgets/drawer_widgets.dart';

class CreateCategoryScreen extends ConsumerWidget {
  final String? categoryId;
  const CreateCategoryScreen({super.key, this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameCtrl = TextEditingController();
    final TextEditingController minTeamsCtrl = TextEditingController();
    final TextEditingController maxTeamsCtrl = TextEditingController();
    final TextEditingController modalitiesCtrl = TextEditingController();
    final TextEditingController allowedGenderCtrl = TextEditingController();
    final TextEditingController maxAgeCtrl = TextEditingController();
    final TextEditingController minAgeCtrl = TextEditingController();
    final TextEditingController statusCtrl = TextEditingController();

    final categoryIdProv = categoryId == null
        ? ref.watch(categoryEmptyProvider)
        : ref.watch(categoryByIdProvider(categoryId!));

    return Scaffold(
      appBar: AppBar(
        title: categoryId == null
            ? const Text("Crear Categoría")
            : const Text("Actualizar Categoría"),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                child: Column(
                  children: [
                    categoryIdProv.when(
                      data: (category) {
                        if (categoryId != null) {
                          // Update inputs controllers
                          nameCtrl.text = category.name ?? '';
                          minTeamsCtrl.text = category.minTeams.toString();
                          maxTeamsCtrl.text = category.maxTeams.toString();
                          modalitiesCtrl.text = category.modalities.join(', ');
                          allowedGenderCtrl.text = category.allowedGender;
                          maxAgeCtrl.text = category.maxAge.toString();
                          minAgeCtrl.text = category.minAge.toString();
                          statusCtrl.text = category.status;
                        }
                        return Column(
                          children: [
                            const Text("Nombre Categoría"),
                            CustomInputText(
                              label: 'Nombre Categoría',
                              hintText: 'Indique un nombre para la categoría',
                              controller: nameCtrl,
                            ),
                            const Text("Mínimo de Equipos"),
                            CustomInputText(
                              label: 'Mínimo de Equipos',
                              hintText: 'Número mínimo de equipos',
                              controller: minTeamsCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Máximo de Equipos"),
                            CustomInputText(
                              label: 'Máximo de Equipos',
                              hintText: 'Número máximo de equipos',
                              controller: maxTeamsCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Modalidades"),
                            CustomInputText(
                              label: 'Modalidades',
                              hintText: 'Modalidades separadas por comas',
                              controller: modalitiesCtrl,
                            ),
                            const Text("Género Permitido"),
                            CustomInputText(
                              label: 'Género Permitido',
                              hintText: 'Género permitido',
                              controller: allowedGenderCtrl,
                            ),
                            const Text("Edad Máxima"),
                            CustomInputText(
                              label: 'Edad Máxima',
                              hintText: 'Edad máxima',
                              controller: maxAgeCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            const Text("Edad Mínima"),
                            CustomInputText(
                              label: 'Edad Mínima',
                              hintText: 'Edad mínima',
                              controller: minAgeCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            
                          ],
                        );
                      },
                      error: (err, trc) {
                        return Column(
                          children: [Text('$err'), Text('$trc')],
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () async {
                          final Category categorySubmit = Category(
                            name: nameCtrl.text,
                            minTeams: int.tryParse(minTeamsCtrl.text) ?? 0,
                            maxTeams: int.tryParse(maxTeamsCtrl.text) ?? 0,
                            modalities: modalitiesCtrl.text
                                .split(',')
                                .map((e) => e.trim())
                                .toList(),
                            allowedGender: allowedGenderCtrl.text,
                            maxAge: int.tryParse(maxAgeCtrl.text) ?? 0,
                            minAge: int.tryParse(minAgeCtrl.text) ?? 0,
                            status: statusCtrl.text ,
                          );
                          print(categorySubmit.toJson());
                          if (categoryId == null) {
                            // Crear
                            ref.read(createCategoryProvider(categorySubmit).future);
                          } else {
                            // Actualizar
                            ref.read(updateCategoryProvider(categorySubmit).future);
                          }

                          //context.push(AppRoutes.categoryScreen);
                          //ref.invalidate(getCategoriesProvider);
                        },
                        child: Text(
                          categoryId == null ? 'Crear' : 'Actualizar',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
