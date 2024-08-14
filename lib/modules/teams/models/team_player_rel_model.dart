// To parse this JSON data, do
//
//     final teamPlayerRelModel = teamPlayerRelModelFromJson(jsonString);

import 'dart:convert';

import 'package:movil_cabi_app/modules/players/models/player_model.dart';
import 'package:movil_cabi_app/modules/teams/models/team_model.dart';

List<TeamPlayerRelModel> teamPlayerRelModelFromJson(String str) => List<TeamPlayerRelModel>.from(json.decode(str).map((x) => TeamPlayerRelModel.fromJson(x)));

String teamPlayerRelModelToJson(List<TeamPlayerRelModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamPlayerRelModel {
    int? teamPlayerRelId;
    bool? teamPlayerRelStatus;
    int? teamPlayerRelNumberPlayer;
    int? teamId;
    int? playerId;
    bool? teamPlayerRelIsCaptain;
    DateTime? teamPlayerRelCreatedAt;
    DateTime? teamPlayerRelUpdatedAt;
    PlayerModel? player;
    TeamModel? team;

    TeamPlayerRelModel({
        this.teamPlayerRelId,
        this.teamPlayerRelStatus,
        this.teamPlayerRelNumberPlayer,
        this.teamId,
        this.playerId,
        this.teamPlayerRelIsCaptain,
        this.teamPlayerRelCreatedAt,
        this.teamPlayerRelUpdatedAt,
        this.player,
        this.team,
    });

    factory TeamPlayerRelModel.fromJson(Map<String, dynamic> json) => TeamPlayerRelModel(
        teamPlayerRelId: json["team_player_rel_id"],
        teamPlayerRelStatus: json["team_player_rel_status"],
        teamPlayerRelNumberPlayer: json["team_player_rel_number_player"],
        teamId: json["team_id"],
        playerId: json["player_id"],
        teamPlayerRelIsCaptain: json["team_player_rel_is_captain"],
        teamPlayerRelCreatedAt: json["team_player_rel_created_at"] == null ? null : DateTime.parse(json["team_player_rel_created_at"]),
        teamPlayerRelUpdatedAt: json["team_player_rel_updated_at"] == null ? null : DateTime.parse(json["team_player_rel_updated_at"]),
        player: json["player"] == null ? null : PlayerModel.fromJson(json["player"]),
        team: json["team"] == null ? null : TeamModel.fromJson(json["team"]),
    );

    Map<String, dynamic> toJson() => {
        "team_player_rel_id": teamPlayerRelId,
        "team_player_rel_status": teamPlayerRelStatus,
        "team_player_rel_number_player": teamPlayerRelNumberPlayer,
        "team_id": teamId,
        "player_id": playerId,
        "team_player_rel_is_captain": teamPlayerRelIsCaptain,
        "team_player_rel_created_at": teamPlayerRelCreatedAt?.toIso8601String(),
        "team_player_rel_updated_at": teamPlayerRelUpdatedAt?.toIso8601String(),
        "player": player?.toJson(),
        "team": team?.toJson(),
    };
}
