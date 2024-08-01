import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cabi_app/models/tournament.dart'; // Ajusta la ruta según tu proyecto

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!
    )));
    
    

final getTournamentsProvider = FutureProvider<List<Tournament>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("/tournaments");
  print(response.data);
  if (response.statusCode != 200) return [];

  final tournaments = (response.data as List<dynamic>).map((item) {
    return Tournament.fromJson(item);
  }).toList();

  return tournaments;
});

final tournamentByIdProvider = FutureProvider.family<Tournament, String>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/tournaments/$id");

  if (response.statusCode != 200)
    return Tournament(
        tournamentId: 0,
        name: "",
        image: '',
        location: '',
        numCourts: 1,
        registrationDate: '',
        startDate: '',
        gameDays: [],
        registrationValue: 0,
        warrantyValue: 0,
        matchValue: 5,
        rules: '',
        phone: '',
        email: '',
        status: '',
        categories: []);

  final tournament = Tournament.fromJson(response.data);

  return tournament;
});

final tournamentEmptyProvider = FutureProvider<Tournament>((ref) {
  return Tournament(
      // tournamentId: 0,
      name: "",
      image: '',
      location: '',
      numCourts: 1,
      registrationDate: '',
      startDate: '',
      gameDays: [],
      registrationValue: 0,
      warrantyValue: 0,
      matchValue: 0,
      rules: '',
      phone: '',
      email: '',
      status: '',
      categories: []);
});

final createTournamentProvider =
    FutureProvider.family<Tournament, Tournament>((ref, tournament) async {
  final dio = ref.watch(dioProvider);
  print("En el provider: ${tournament.toJson()}");
  final response = await dio.post('/tournaments',
      data: tournament.image != ""
          ? {
              "name": tournament.name,
              "image": tournament.image,
              "location": tournament.location,
              "num_courts": tournament.numCourts,
              "registration_date": tournament.registrationDate,
              "start_date": tournament.startDate,
              "game_days": [...tournament.gameDays!],
              "registration_value": tournament.registrationValue,
              "warranty_value": tournament.warrantyValue,
              "match_value": tournament.matchValue,
              "rules": tournament.rules,
              "phone": tournament.phone,
              "email": tournament.email,
              // "status": tournament.status,
              "categories": [...tournament.categories!],
            }
          : {
              // "tournament_id": -1,
              "name": tournament.name,
              "location": tournament.location,
              "num_courts": tournament.numCourts,
              "registration_date": tournament.registrationDate,
              "start_date": tournament.startDate,
              "game_days": [...tournament.gameDays!],
              "registration_value": tournament.registrationValue,
              "warranty_value": tournament.warrantyValue,
              "match_value": tournament.matchValue,
              "rules": tournament.rules,
              "phone": tournament.phone,
              "email": tournament.email,
              // "status": tournament.status,
              "categories": [...tournament.categories!],
            });
  print("respuesta del back: ${response.data}");
  if (response.statusCode != 201) {
    throw Exception('Failed to create tournament');
  }
  //   return Tournament(
  //       tournamentId: 0,
  //       name: "",
  //       image: '',
  //       location: '',
  //       numCourts: 1,
  //       registrationDate: '',
  //       startDate: '',
  //       gameDays: [],
  //       registrationValue: 0,
  //       warrantyValue: 0,
  //       matchValue: 0,
  //       rules: '',
  //       phone: '',
  //       email: '',
  //       status: '',
  //       categories: []);
  // }

  return response.data!;
});



final updateTournamentProvider = FutureProvider.family<Tournament, Tournament>((ref, tournament) async {
  final dio = ref.watch(dioProvider);

  final response = await dio
      .patch<Tournament>('/tournaments/${tournament.tournamentId}', data: {
    "name": tournament.name,
    "image": tournament.image,
    "location": tournament.location,
    "num_courts": tournament.numCourts,
    "registration_date": null,
    "start_date": null,
    "game_days": null,
    "registration_value": 0,
    "warranty_value": 0,
    "match_value": 5,
    "rules": null,
    "phone": null,
    "email": null,
    "status": "active",
  });
  print(response.data!);
  if (response.statusCode != 200) {
    return Tournament(
        tournamentId: 0,
        name: "",
        image: '',
        location: '',
        numCourts: 1,
        registrationDate: '',
        startDate: '',
        gameDays: [],
        registrationValue: 0,
        warrantyValue: 0,
        matchValue: 0,
        rules: '',
        phone: '',
        email: '',
        status: '',
        categories: []);
  }

  return response.data!;
});

final deleteTournamentProvider =
    FutureProvider.family<Tournament, String>((ref, id) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.delete<Tournament>('/tournaments/$id');

  if (response.statusCode != 200) {
    return Tournament(
        tournamentId: 0,
        name: "",
        image: '',
        location: '',
        numCourts: 1,
        registrationDate: '',
        startDate: '',
        gameDays: [],
        registrationValue: 0,
        warrantyValue: 0,
        matchValue: 0,
        rules: '',
        phone: '',
        email: '',
        status: '',
        categories: []);
  }

  return response.data!;
});
