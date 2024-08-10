// To parse this JSON data, do
//
//     final tournamentModel = tournamentModelFromJson(jsonString);

import 'dart:convert';

List<TournamentModel> tournamentModelFromJson(String str) => List<TournamentModel>.from(json.decode(str).map((x) => TournamentModel.fromJson(x)));

String tournamentModelToJson(List<TournamentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TournamentModel {
    int? tournamentId;
    String? tournamentName;
    String? tournamentImageUrl;
    String? tournamentLocation;
    int? tournamentNumCourts;
    DateTime? tournamentRegistrationDate;
    DateTime? tournamentStartDate;
    int? tournamentRegistrationValue;
    int? tournamentWarrantyValue;
    int? tournamentMatchValue;
    dynamic tournamentRules;
    dynamic tournamentPhone;
    dynamic tournamentEmail;
    bool? tournamentStatus;
    DateTime? tournamentCreatedAt;
    DateTime? tournamentUpdatedAt;

    TournamentModel({
        this.tournamentId,
        this.tournamentName,
        this.tournamentImageUrl,
        this.tournamentLocation,
        this.tournamentNumCourts,
        this.tournamentRegistrationDate,
        this.tournamentStartDate,
        this.tournamentRegistrationValue,
        this.tournamentWarrantyValue,
        this.tournamentMatchValue,
        this.tournamentRules,
        this.tournamentPhone,
        this.tournamentEmail,
        this.tournamentStatus,
        this.tournamentCreatedAt,
        this.tournamentUpdatedAt,
    });

    factory TournamentModel.fromJson(Map<String, dynamic> json) => TournamentModel(
        tournamentId: json["tournament_id"],
        tournamentName: json["tournament_name"],
        tournamentImageUrl: json["tournament_image_url"],
        tournamentLocation: json["tournament_location"],
        tournamentNumCourts: json["tournament_num_courts"],
        tournamentRegistrationDate: json["tournament_registration_date"] == null ? null : DateTime.parse(json["tournament_registration_date"]),
        tournamentStartDate: json["tournament_start_date"] == null ? null : DateTime.parse(json["tournament_start_date"]),
        tournamentRegistrationValue: json["tournament_registration_value"],
        tournamentWarrantyValue: json["tournament_warranty_value"],
        tournamentMatchValue: json["tournament_match_value"],
        tournamentRules: json["tournament_rules"],
        tournamentPhone: json["tournament_phone"],
        tournamentEmail: json["tournament_email"],
        tournamentStatus: json["tournament_status"],
        tournamentCreatedAt: json["tournament_created_at"] == null ? null : DateTime.parse(json["tournament_created_at"]),
        tournamentUpdatedAt: json["tournament_updated_at"] == null ? null : DateTime.parse(json["tournament_updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "tournament_id": tournamentId,
        "tournament_name": tournamentName,
        "tournament_image_url": tournamentImageUrl,
        "tournament_location": tournamentLocation,
        "tournament_num_courts": tournamentNumCourts,
        "tournament_registration_date": tournamentRegistrationDate?.toIso8601String(),
        "tournament_start_date": tournamentStartDate?.toIso8601String(),
        "tournament_registration_value": tournamentRegistrationValue,
        "tournament_warranty_value": tournamentWarrantyValue,
        "tournament_match_value": tournamentMatchValue,
        "tournament_rules": tournamentRules,
        "tournament_phone": tournamentPhone,
        "tournament_email": tournamentEmail,
        "tournament_status": tournamentStatus,
        "tournament_created_at": tournamentCreatedAt?.toIso8601String(),
        "tournament_updated_at": tournamentUpdatedAt?.toIso8601String(),
    };
}
