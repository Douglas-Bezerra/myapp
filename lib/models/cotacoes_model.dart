import 'dart:convert';

CotacoesModel cotacoesModelFromJson(String str) => CotacoesModel.fromJson(json.decode(str));
String cotacoesModelToJson(CotacoesModel dados) => json.encode(dados.toJson());

class CotacoesModel {
  String code;
  String codein;
  String name;
  String high;
  String low;
  String timestamp;
  String createdate;

  CotacoesModel({
    required this.code,
    required this.codein,
    required this.name,
    required this.high,
    required this.low,
    required this.timestamp,
    required this.createdate,
  });

  factory CotacoesModel.fromJson(Map<String, dynamic> json) => CotacoesModel(
    code: json["code"],
    codein: json["codein"],
    name: json["name"],
    high: json["high"],
    low: json["low"],
    timestamp: json["timestamp"],
    createdate: json["create_date"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "codein": codein,
    "name": name,
    "high": high,
    "low": low,
    "timestamp": timestamp,
    "createdate": createdate,
  };
}