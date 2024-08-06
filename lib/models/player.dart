// To parse this JSON data, do
//
//     final player = playerFromJson(jsonString);

import 'dart:convert';

Player playerFromJson(String str) => Player.fromJson(json.decode(str));

String playerToJson(Player data) => json.encode(data.toJson());

class Player {
    final int? playerId;
    final String? firstName;
    final String? lastName;
    final String? cedula;
    final String? playerNumber;
    final String? phone;
    final String? email;
    final String? gender;
    final DateTime? birthdate;
    final String? status;

    Player({
      this.playerId,
      this.firstName,
      this.lastName,
      this.cedula,
      this.playerNumber,
      this.phone,
      this.email,
      this.gender,
      this.birthdate,
      this.status,
    });

    factory Player.fromJson(Map<String, dynamic> json) => Player(
        firstName: json["first_name"],
        lastName: json["last_name"],
        cedula: json["cedula"],
        playerNumber: json["player_number"],
        phone: json["phone"],
        email: json["email"],
        gender: json["gender"],
        birthdate: DateTime.parse(json["birthdate"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "cedula": cedula,
        "player_number": playerNumber,
        "phone": phone,
        "email": email,
        "gender": gender,
        "birthdate": "${birthdate?.year.toString().padLeft(4, '0')}-${birthdate?.month.toString().padLeft(2, '0')}-${birthdate?.day.toString().padLeft(2, '0')}",
        "status": status,
    };
}
