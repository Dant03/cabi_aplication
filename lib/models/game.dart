// To parse this JSON data, do
//
//     final game = gameFromJson(jsonString);

import 'dart:convert';

Game gameFromJson(String str) => Game.fromJson(json.decode(str));

String gameToJson(Game data) => json.encode(data.toJson());

class Game {
    final int localTeamId;
    final int visitorTeamId;
    final DateTime date;
    final String court;
    final int localScore;
    final int visitorScore;
    final int tournamentId;
    final int categoryId;

    Game({
        required this.localTeamId,
        required this.visitorTeamId,
        required this.date,
        required this.court,
        required this.localScore,
        required this.visitorScore,
        required this.tournamentId,
        required this.categoryId,
    });

    factory Game.fromJson(Map<String, dynamic> json) => Game(
        localTeamId: json["local_team_id"],
        visitorTeamId: json["visitor_team_id"],
        date: DateTime.parse(json["date"]),
        court: json["court"],
        localScore: json["local_score"],
        visitorScore: json["visitor_score"],
        tournamentId: json["tournament_id"],
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "local_team_id": localTeamId,
        "visitor_team_id": visitorTeamId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "court": court,
        "local_score": localScore,
        "visitor_score": visitorScore,
        "tournament_id": tournamentId,
        "category_id": categoryId,
    };
}
