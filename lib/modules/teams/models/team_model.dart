// To parse this JSON data, do
//
//     final teamMode = teamModeFromJson(jsonString);

import 'dart:convert';

TeamModel teamModeFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModeToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
    int? teamId;
    String? teamName;
    String? teamLogo;
    String? teamPhone;
    String? teamEmail;
    bool? teamStatus;
    DateTime? teamCreatedAt;
    DateTime? teamUpdatedAt;

    TeamModel({
        this.teamId,
        this.teamName,
        this.teamLogo,
        this.teamPhone,
        this.teamEmail,
        this.teamStatus,
        this.teamCreatedAt,
        this.teamUpdatedAt,
    });

    factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
        teamId: json["team_id"],
        teamName: json["team_name"],
        teamLogo: json["team_logo"],
        teamPhone: json["team_phone"],
        teamEmail: json["team_email"],
        teamStatus: json["team_status"],
        teamCreatedAt: json["team_created_at"] == null ? null : DateTime.parse(json["team_created_at"]),
        teamUpdatedAt: json["team_updated_at"] == null ? null : DateTime.parse(json["team_updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "team_id": teamId,
        "team_name": teamName,
        "team_logo": teamLogo,
        "team_phone": teamPhone,
        "team_email": teamEmail,
        "team_status": teamStatus,
        "team_created_at": teamCreatedAt?.toIso8601String(),
        "team_updated_at": teamUpdatedAt?.toIso8601String(),
    };
}
