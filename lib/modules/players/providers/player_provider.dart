import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/players/models/player_model.dart';

class PlayerProvider {
  static final getPlayerProfileByUserId =
      FutureProvider.autoDispose.family<PlayerModel, int?>((ref, id) async {
    // try {
    if (id == null) return PlayerModel();
    final response = await dio.get('/players/user-id/$id');
    if (response.statusCode != 200) throw Exception();
    return PlayerModel.fromJson(response.data);
    // } catch (e) {
    //   return PlayerModel();
    // }
  });
}
