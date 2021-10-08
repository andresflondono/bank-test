import 'dart:convert';

import 'package:bank_todo/data/models/bank_current_account.dart';
import 'package:bank_todo/data/models/bank_thrift_account.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.name,
    this.email,
    this.lastname,
    this.token,
    this.current,
    this.thrift,
  });

  String id;
  String name;
  String email;
  String lastname;
  String token;
  BankAccountCurrent current;
  BankAccountThrift thrift;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        thrift: BankAccountThrift.fromJson(
            Map<String, dynamic>.from(json["thrift"])),
        lastname: json["lastname"],
        token: json["token"],
        current: BankAccountCurrent.fromJson(
            Map<String, dynamic>.from(json["current"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "lastname": lastname,
        "token": token,
        "current": current.toJson(),
        "thrift": thrift.toJson(),
      };
}
