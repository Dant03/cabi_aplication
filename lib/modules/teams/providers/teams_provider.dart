import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movil_cabi_app/config/dio_config.dart';
import 'package:movil_cabi_app/modules/teams/models/team_model.dart';

class TeamsProvider {
  static final getTeamsProvider =
      FutureProvider.autoDispose<List<TeamModel>>((ref) async {
    try {
      final response = await dio.get('/teams');
      if (response.statusCode != 200) return [];
      return (response.data as List<dynamic>)
          .map((t) => TeamModel.fromJson(t))
          .toList();
    } catch (e) {
      return [];
    }
  });

  static final getTeamByIdProvider =
      FutureProvider.autoDispose.family<TeamModel, int>((ref, id) async {
    try {
      final response = await dio.get('/teams/$id');
      if (response.statusCode != 200) return TeamModel();
      return TeamModel.fromJson(response.data);
    } catch (e) {
      return TeamModel();
    }
  });

  // static final getTeamsByUserId = FutureProvider.autoDispose.family<>();
}
