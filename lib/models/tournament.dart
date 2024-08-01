// To parse this JSON data, do
//
//     final tournament = tournamentFromJson(jsonString);

import 'dart:convert';

Tournament tournamentFromJson(String str) => Tournament.fromJson(json.decode(str));

String tournamentToJson(Tournament data) => json.encode(data.toJson());

class Tournament {
    final int? tournamentId;
    final String? name;
    final String? image;
    final String ?location;
    final int? numCourts;
    final String? registrationDate;
    final String? startDate;
    final List<String>? gameDays;
    final int? registrationValue;
    final int? warrantyValue;
    final int? matchValue;
    final String? rules;
    final String? phone;
    final String? email;
    final String? status;
    final List<String>? categories;

    Tournament({
        this.tournamentId,
        this.name,
        this.image,
        this.location,
        this.numCourts,
        this.registrationDate,
        this.startDate,
        this.gameDays,
        this.registrationValue,
        this.warrantyValue,
        this.matchValue,
        this.rules,
        this.phone,
        this.email,
        this.status,
        this.categories,
    });

    factory Tournament.fromJson(Map<String, dynamic> json) => Tournament(
        tournamentId: json["tournament_id"]??0,
        name: json["name"] ?? '', 
        image: json["image"] ?? '', 
        location: json["location"] ?? '', 
        numCourts: json["num_courts"] ?? 0, 
        registrationDate: json["registration_date"] ?? '', 
        startDate: json["start_date"] ?? '', 
        gameDays: json["game_days"] == null ? [] : List<String>.from(json["game_days"].map((x) => x)), 
        registrationValue: json["registration_value"] ?? 0, 
        warrantyValue: json["warranty_value"] ?? 0, 
        matchValue: json["match_value"] ?? 0, 
        rules: json["rules"] ?? '', 
        phone: json["phone"] ?? '', 
        email: json["email"] ?? '', 
        status: json["status"] ?? '', 
        categories: json["categories"] == null ? [] : List<String>.from(json["categories"].map((x) => x)), 
    );

    Map<String, dynamic> toJson() => {
        "tournament_id": tournamentId,
        "name": name,
        "image": image,
        "location": location,
        "num_courts": numCourts,
        "registration_date": registrationDate,
        "start_date": startDate,
        "game_days":  gameDays==null ? [] : List<dynamic>.from(gameDays!.map((x) => x)),
        "registration_value": registrationValue,
        "warranty_value": warrantyValue,
        "match_value": matchValue,
        "rules": rules,
        "phone": phone,
        "email": email,
        "status": status,
        "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x)),
    };
}
