import 'dart:convert';

BankAccountThrift bankAccountThriftFromJson(String str) =>
    BankAccountThrift.fromJson(json.decode(str));

String bankAccountThriftToJson(BankAccountThrift data) =>
    json.encode(data.toJson());

class BankAccountThrift {
  BankAccountThrift({
    this.money,
  });

  int money;

  factory BankAccountThrift.fromJson(Map<String, dynamic> json) =>
      BankAccountThrift(
        money: json["money"],
      );

  Map<String, dynamic> toJson() => {
        "money": money,
      };
}
