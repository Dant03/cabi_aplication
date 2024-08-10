// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? userId;
    String? userFirstName;
    String? userLastName;
    String? userEmail;
    String? userPassword;
    String? userRole;
    bool? userStatus;
    DateTime? userCreatedAt;
    DateTime? userUpdatedAt;

    UserModel({
        this.userId,
        this.userFirstName,
        this.userLastName,
        this.userEmail,
        this.userPassword,
        this.userRole,
        this.userStatus,
        this.userCreatedAt,
        this.userUpdatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userRole: json["user_role"],
        userStatus: json["user_status"],
        userCreatedAt: json["user_created_at"] == null ? null : DateTime.parse(json["user_created_at"]),
        userUpdatedAt: json["user_updated_at"] == null ? null : DateTime.parse(json["user_updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_role": userRole,
        "user_status": userStatus,
        "user_created_at": userCreatedAt?.toIso8601String(),
        "user_updated_at": userUpdatedAt?.toIso8601String(),
    };
}
