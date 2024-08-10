// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:movil_cabi_app/modules/users/models/user_model.dart';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  bool? ok;
  UserModel? user;
  String? message;

  LoginResponseModel({
    this.ok,
    this.user,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        ok: json["ok"],
        user: UserModel.fromJson(json["user"]),
        message: json["message"],
      );
}
