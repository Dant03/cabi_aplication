import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/players/models/player_model.dart';

class PlayerProvider {

  static final playerProvider = StateProvider((ref) => PlayerModel());


  static final getPlayerProfileByUserId =
      FutureProvider.autoDispose.family<PlayerModel, int?>((ref, id) async {
    if (id == null) return PlayerModel();
    final response = await dio.get('/players/user-id/$id');
    if (response.statusCode != 200) throw Exception();
    return PlayerModel.fromJson(response.data);
  });

  static final postPlayerProfile =
      FutureProvider.family<void, PlayerModel>((ref, player) async {
    try {
      print("En el provider");
      final response = await dio.post('/players', data: {
        "player_dni": player.playerDni,
        "player_phone": player.playerPhone,
        "player_gender": player.playerGender,
        "player_birthdate": player.playerBirthdate.toString(),
        "user_id": player.userId,
      });
      print("respuesta del backend");
      print(response.data);
      if (response.statusCode != 200) {
        ref.read(playerProvider.notifier).update((s) => s = PlayerModel());
        Get.snackbar('Error',
            'No se pudo crear el perfil del jugador: ${response.data["message"]}');
        return;
      } else {
        ref.invalidate(getPlayerProfileByUserId(player.userId));
        ref.read(playerProvider.notifier).update((s) => PlayerModel.fromJson(response.data));
        Get.back();
      }
    } catch (e) {
      print('Excepcion del player provider');
      print(e);
      throw Exception();
    }
  });
}