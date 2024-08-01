import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/team.dart'; // Ajusta la ruta según tu proyecto

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!)));

final getTeamsProvider = FutureProvider<List<Team>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("/teams");
  print(response.data);
  if (response.statusCode != 200) return [];

  final teams = (response.data as List<dynamic>).map((item) {
    return Team.fromJson(item);
  }).toList();

  return teams;
});

final teamByIdProvider = FutureProvider.family<Team, String>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/teams/$id");

  if (response.statusCode != 200)
    return Team(
        name: "",
        logo: '',
        captain: '',
        phone: '',
        email: '',
        categoryId: 0,
        players: [],
        status: '',
        userId: 0);

  final team = Team.fromJson(response.data);

  return team;
});

final teamEmptyProvider = FutureProvider<Team>((ref) {
  return Team(
      name: "",
      logo: '',
      captain: '',
      phone: '',
      email: '',
      categoryId: 0,
      players: [],
      status: '',
      userId: 0);
});

final createTeamProvider = FutureProvider.family<Team, Team>((ref, team) async {
  final dio = ref.watch(dioProvider);
  print("En el provider: ${team.toJson()}");
  final response = await dio.post('/teams',
      data: team.logo != ""
          ? {
              "name": team.name,
              "logo": team.logo,
              "captain": team.captain,
              "phone": team.phone,
              "email": team.email,
              "category_id": team.categoryId,
              "players": team.players,
              // "status": team.status,
              "user_id": team.userId,
            }
          : {

            "name": team.name,
            "captain": team.captain,
            "phone": team.phone,
            "email": team.email,
            "category_id": team.categoryId,
            "players": team.players,
            // "status": team.status,
            "user_id": team.userId,
          });
  print("respuesta del back: ${response.data}");
  if (response.statusCode != 201) {
    throw Exception('Failed to create team');
  }

  return Team.fromJson(response.data);
});

final updateTeamProvider = FutureProvider.family<Team, Team>((ref, team) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.patch<Team>('/teams/${team.name}', data: {
    "name": team.name,
    "logo": team.logo,
    "captain": team.captain,
    "phone": team.phone,
    "email": team.email,
    "category_id": team.categoryId,
    "players": team.players,
    "status": team.status,
    "user_id": team.userId,
  });
  print(response.data!);
  if (response.statusCode != 200) {
    return Team(
        name: "",
        logo: '',
        captain: '',
        phone: '',
        email: '',
        categoryId: 0,
        players: [],
        status: '',
        userId: 0);
  }

  return response.data!;
});

final deleteTeamProvider =
    FutureProvider.family<Team, String>((ref, name) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.delete<Team>('/teams/$name');

  if (response.statusCode != 200) {
    return Team(
        name: "",
        logo: '',
        captain: '',
        phone: '',
        email: '',
        categoryId: 0,
        players: [],
        status: '',
        userId: 0);
  }

  return response.data!;
});
