// To parse this JSON data, do
//
//     final playerModel = playerModelFromJson(jsonString);

import 'dart:convert';

PlayerModel playerModelFromJson(String str) => PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
    String? playerDni;
    String? playerPhone;
    String? playerGender;
    DateTime? playerBirthdate;
    int? userId;
    int? playerId;
    bool? playerStatus;
    DateTime? playerCreatedAt;
    DateTime? playerUpdatedAt;

    PlayerModel({
        this.playerDni,
        this.playerPhone,
        this.playerGender,
        this.playerBirthdate,
        this.userId,
        this.playerId,
        this.playerStatus,
        this.playerCreatedAt,
        this.playerUpdatedAt,
    });

    factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        playerDni: json["player_dni"],
        playerPhone: json["player_phone"],
        playerGender: json["player_gender"],
        playerBirthdate: json["player_birthdate"] == null ? null : DateTime.parse(json["player_birthdate"]),
        userId: json["user_id"],
        playerId: json["player_id"],
        playerStatus: json["player_status"],
        playerCreatedAt: json["player_created_at"] == null ? null : DateTime.parse(json["player_created_at"]),
        playerUpdatedAt: json["player_updated_at"] == null ? null : DateTime.parse(json["player_updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "player_dni": playerDni,
        "player_phone": playerPhone,
        "player_gender": playerGender,
        "player_birthdate": "${playerBirthdate!.year.toString().padLeft(4, '0')}-${playerBirthdate!.month.toString().padLeft(2, '0')}-${playerBirthdate!.day.toString().padLeft(2, '0')}",
        "user_id": userId,
        "player_id": playerId,
        "player_status": playerStatus,
        "player_created_at": playerCreatedAt?.toIso8601String(),
        "player_updated_at": playerUpdatedAt?.toIso8601String(),
    };
}
