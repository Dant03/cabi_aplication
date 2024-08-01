import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/models/category.dart'; // Ajusta la ruta según tu proyecto

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!
    )));

final getCategoriesProvider = FutureProvider<List<Category>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("/categories");
  print(response.data);
  if (response.statusCode != 200) return [];

  final categories = (response.data as List<dynamic>).map((item) {
    return Category.fromJson(item);
  }).toList();

  return categories;
});

final categoryByIdProvider =
    FutureProvider.family<Category, String>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/categories/$id");

  if (response.statusCode != 200)
    return Category(
        name: "",
        minTeams: 0,
        maxTeams: 0,
        modalities: [],
        allowedGender: '',
        maxAge: 0,
        minAge: 0,
        status: '');

  final category = Category.fromJson(response.data);

  return category;
});

final categoryEmptyProvider = FutureProvider<Category>((ref) {
  return Category(
      name: "",
      minTeams: 0,
      maxTeams: 0,
      modalities: [],
      allowedGender: '',
      maxAge: 0,
      minAge: 0,
      status: '');
});

final createCategoryProvider =
    FutureProvider.family<Category, Category>((ref, category) async {
  final dio = ref.watch(dioProvider);
  print("En el provider: ${category.toJson()}");
  final response = await dio.post('/categories', data: {
    "name": category.name,
    "min_teams": category.minTeams,
    "max_teams": category.maxTeams,
    "modalities": category.modalities,
    "allowed_gender": category.allowedGender,
    "max_age": category.maxAge,
    "min_age": category.minAge,
    // "status": category.status,
  });
  print("respuesta del back: ${response.data}");
  if (response.statusCode != 201) {
    throw Exception('Failed to create category');
  }

  return Category.fromJson(response.data);
});

final updateCategoryProvider =
    FutureProvider.family<Category, Category>((ref, category) async {
  final dio = ref.watch(dioProvider);

  final response =
      await dio.patch<Category>('/categories/${category.name}', data: {
    "name": category.name,
    "min_teams": category.minTeams,
    "max_teams": category.maxTeams,
    "modalities": category.modalities,
    "allowed_gender": category.allowedGender,
    "max_age": category.maxAge,
    "min_age": category.minAge,
    "status": 'active',
  });
  print(response.data!);
  if (response.statusCode != 200) {
    return Category(
        name: "",
        minTeams: 0,
        maxTeams: 0,
        modalities: [],
        allowedGender: '',
        maxAge: 0,
        minAge: 0,
        status: '');
  }

  return response.data!;
});

final deleteCategoryProvider =
    FutureProvider.family<Category, String>((ref, name) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.delete<Category>('/categories/$name');

  if (response.statusCode != 200) {
    return Category(
        name: "",
        minTeams: 0,
        maxTeams: 0,
        modalities: [],
        allowedGender: '',
        maxAge: 0,
        minAge: 0,
        status: '');
  }

  return response.data!;
});
