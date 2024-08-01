// To parse this JSON data, do
//
//     final teamPlayer = teamPlayerFromJson(jsonString);

import 'dart:convert';

TeamPlayer teamPlayerFromJson(String str) => TeamPlayer.fromJson(json.decode(str));

String teamPlayerToJson(TeamPlayer data) => json.encode(data.toJson());

class TeamPlayer {
    final int teamId;
    final int playerId;

    TeamPlayer({
        required this.teamId,
        required this.playerId,
    });

    factory TeamPlayer.fromJson(Map<String, dynamic> json) => TeamPlayer(
        teamId: json["team_id"],
        playerId: json["player_id"],
    );

    Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "player_id": playerId,
    };
}
