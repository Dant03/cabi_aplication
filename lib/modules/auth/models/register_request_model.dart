// To parse this JSON data, do
//
//     final registerRequestModel = registerRequestModelFromJson(jsonString);

import 'dart:convert';

RegisterRequestModel registerRequestModelFromJson(String str) => RegisterRequestModel.fromJson(json.decode(str));

String registerRequestModelToJson(RegisterRequestModel data) => json.encode(data.toJson());

class RegisterRequestModel {
    String? userFirstName;
    String? userLastName;
    String? userEmail;
    String? userPassword;

    RegisterRequestModel({
        this.userFirstName,
        this.userLastName,
        this.userEmail,
        this.userPassword,
    });

    factory RegisterRequestModel.fromJson(Map<String, dynamic> json) => RegisterRequestModel(
        userFirstName: json["user_first_name"],
        userLastName: json["user_last_name"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
    );

    Map<String, dynamic> toJson() => {
        "user_first_name": userFirstName,
        "user_last_name": userLastName,
        "user_email": userEmail,
        "user_password": userPassword,
    };
}
