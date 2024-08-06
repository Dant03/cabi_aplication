import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/player.dart'; // Ajusta la ruta según tu proyecto

final dioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    validateStatus: (status) => true,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    baseUrl: dotenv.env['BASE_URL']!
    )));

final getPlayersProvider = FutureProvider<List<Player>>((ref) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.get("/players");
  print(response.data);
  if (response.statusCode != 200) return [];

  final players = (response.data as List<dynamic>).map((item) {
    return Player.fromJson(item);
  }).toList();

  return players;
});

final playerByIdProvider =
    FutureProvider.family<Player, String>((ref, id) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/players/$id");

  if (response.statusCode != 200)
    return Player(
        firstName: "",
        lastName: "",
        cedula: "",
        playerNumber: "",
        phone: '',
        email: '',
        gender: '',
        birthdate: DateTime.now(),
        // status: ''
        );

  final player = Player.fromJson(response.data);

  return player;
});

final playerEmptyProvider = FutureProvider<Player>((ref) {
  return Player(
      firstName: "",
      lastName: "",
      cedula: "",
      playerNumber: "",
      phone: '',
      email: '',
      gender: '',
      birthdate: DateTime.now(),
      // status: ''
      );
});

final createPlayerProvider =
    FutureProvider.family<Player, Player>((ref, player) async {
  final dio = ref.watch(dioProvider);
  print("En el provider: ${player.toJson()}");
  final response = await dio.post('/players', data: {
    "first_name": player.firstName,
    "last_name": player.lastName,
    "cedula": player.cedula,
    "player_number": player.playerNumber,
    "phone": player.phone,
    "email": player.email,
    "gender": player.gender,
    "birthdate": player.birthdate?.toIso8601String(),
    // "status": player.status,
  });
  print("respuesta del back: ${response.data}");
  if (response.statusCode != 201) {
    throw Exception('Failed to create player');
  }

  return Player.fromJson(response.data);
});

final updatePlayerProvider =
    FutureProvider.family<Player, Player>((ref, player) async {
  final dio = ref.watch(dioProvider);

  final response =
      await dio.patch<Player>('/players/${player.playerNumber}', data: {
    "first_name": player.firstName,
    "last_name": player.lastName,
    "cedula": player.cedula,
    "player_number": player.playerNumber,
    "phone": player.phone,
    "email": player.email,
    "gender": player.gender,
    "birthdate": player.birthdate?.toIso8601String(),
    // "status": player.status,
  });
  print(response.data!);
  if (response.statusCode != 200) {
    return Player(
        firstName: "",
        lastName: "",
        cedula: "",
        playerNumber: "",
        phone: '',
        email: '',
        gender: '',
        birthdate: DateTime.now(),
        // status: ''
        );
  }

  return response.data!;
});

final deletePlayerProvider =
    FutureProvider.family<Player, String>((ref, id) async {
  final dio = ref.watch(dioProvider);

  final response = await dio.delete<Player>('/players/$id');

  if (response.statusCode != 200) {
    return Player(
        firstName: "",
        lastName: "",
        cedula: "",
        playerNumber: "",
        phone: '',
        email: '',
        gender: '',
        birthdate: DateTime.now(),
        // status: ''
        );
  }

  return response.data!;
});
