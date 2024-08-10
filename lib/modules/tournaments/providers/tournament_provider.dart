import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/tournaments/models/tournament_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentProvider {
  static final getTournamentsProvider =
      FutureProvider<List<TournamentModel>?>((ref) async {
    try {
      final response = await dio.get('/tournaments');
      print(response.data);
      if (response.statusCode != 200) return null;

      return (response.data as List<dynamic>).map((t) => TournamentModel.fromJson(t)).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  });
}
