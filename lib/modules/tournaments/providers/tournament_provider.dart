import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/tournaments/models/tournament_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TournamentProvider {
  static final getTournamentsProvider =
      FutureProvider.autoDispose<List<TournamentModel>>((ref) async {
    try {
      final response = await dio.get('/tournaments');
      if (response.statusCode != 200 ||
          (response.data as List<dynamic>).isEmpty) throw Exception();
      return (response.data as List<dynamic>)
          .map((t) => TournamentModel.fromJson(t))
          .toList();
    } catch (e) {
      throw Exception();
    }
  });

  static final getTournamentByIdProvider =
      FutureProvider.autoDispose.family<TournamentModel, int>((ref, id) async {
    try {
      final response = await dio.get('/tournaments/$id');
      if (response.statusCode != 200) return TournamentModel();
      return TournamentModel.fromJson(response.data);
    } catch (e) {
      return TournamentModel();
    }
  });
  //
}
