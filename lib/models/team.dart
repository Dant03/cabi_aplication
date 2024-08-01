// To parse this JSON data, do
//
//     final team = teamFromJson(jsonString);

import 'dart:convert';

Team teamFromJson(String str) => Team.fromJson(json.decode(str));

String teamToJson(Team data) => json.encode(data.toJson());

class Team {
    final int? teamId;
    final String? name;
    final String? logo;
    final String? captain;
    final String? phone;
    final String? email;
    final int? categoryId;
    final List<String>? players;
    final String? status;
    final int? userId;

    Team({
      this.teamId,
        this.name,
        this.logo,
        this.captain,
        this.phone,
        this.email,
        this.categoryId,
        this.players,
        this.status,
        this.userId,
    });

    factory Team.fromJson(Map<String, dynamic> json) => Team(
        name: json["name"],
        logo: json["logo"],
        captain: json["captain"],
        phone: json["phone"],
        email: json["email"],
        categoryId: json["category_id"],
        players: json["players"] == null ? [] :  List<String>.from(json["players"].map((x) => x)),
        status: json["status"],
        userId: json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "captain": captain,
        "phone": phone,
        "email": email,
        "category_id": categoryId,
        "players": players ==null ? [] : List<dynamic>.from(players!.map((x) => x)),
        "status": status,
        "user_id": userId,
    };
}
