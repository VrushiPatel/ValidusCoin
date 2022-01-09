// To parse this JSON data, do
//
//     final stockResponse = stockResponseFromJson(jsonString);

import 'dart:convert';

StockResponse stockResponseFromJson(String str) =>
    StockResponse.fromJson(json.decode(str));

String stockResponseToJson(StockResponse data) => json.encode(data.toJson());

class StockResponse {
  StockResponse(this.success, {this.statusCode, this.data, this.message});

  bool success;
  String? message;
  int? statusCode;
  List<Datum>? data;

  factory StockResponse.fromJson(Map<String, dynamic> json) => StockResponse(
        json["success"],
        statusCode: json["statusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.stockName,
    this.price,
    this.dayGain,
    this.lastTrade,
    this.extendedHours,
    this.lastPrice,
  });

  String? id;
  String? stockName;
  double? price;
  double? dayGain;
  int? lastTrade;
  int? extendedHours;
  double? lastPrice;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        stockName: json["stockName"],
        price: json["price"].toDouble(),
        dayGain: json["dayGain"].toDouble(),
        lastTrade: int.parse(json["lastTrade"]),
        extendedHours: int.parse(json["extendedHours"]),
        lastPrice: json["lastPrice"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stockName": stockName,
        "price": price,
        "dayGain": dayGain,
        "lastTrade": lastTrade,
        "extendedHours": extendedHours,
        "lastPrice": lastPrice,
      };
}
