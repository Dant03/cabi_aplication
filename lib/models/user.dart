// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    final int? userId;
    final String name;
    final String lastName;
    final String email;
    final String password;
    final String role;
    final String status;

    User({
        this.userId,
        required this.name,
        required this.lastName,
        required this.email,
        required this.password,
        required this.role,
        required this.status,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["user_id"],
        name: json["name"],
        lastName: json["last_name"],
        email: json["email"],
        password: json["password"],
        role: json["role"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "last_name": lastName,
        "email": email,
        "password": password,
        "role": role,
        "status": status,
    };
}
