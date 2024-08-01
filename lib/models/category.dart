// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  
    final int? categoryId;
    final String? name;
    final int? minTeams;
    final int maxTeams;
    final List<String> modalities;
    final String allowedGender;
    final int maxAge;
    final int minAge;
    final String status;

    Category({      
      this.categoryId,
      this.name,
      this.minTeams,
      required this.maxTeams,
      required this.modalities,
      required this.allowedGender,
      required this.maxAge,
      required this.minAge,
      required this.status,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        minTeams: json["min_teams"] ?? 0,
        maxTeams: json["max_teams"],
        modalities: List<String>.from(json["modalities"].map((x) => x)),
        allowedGender: json["allowed_gender"],
        maxAge: json["max_age"],
        minAge: json["min_age"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "min_teams": minTeams,
        "max_teams": maxTeams,
        "modalities": List<dynamic>.from(modalities.map((x) => x)),
        "allowed_gender": allowedGender,
        "max_age": maxAge,
        "min_age": minAge,
        "status": status,
    };
}
