// To parse this JSON data, do
//
//  final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:transport_dashboard/models/admin.dart';


LoginResponse loginResponseFromJson(String str) => LoginResponse.fromMap(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {

    LoginResponse({
        required this.ok,
        required this.admin,
        required this.token,
    });

    bool ok;
    Admin admin;
    String token;

    factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        admin: Admin.fromMap(json["admin"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": admin.toJson(),
        "token": token,
    };
}



