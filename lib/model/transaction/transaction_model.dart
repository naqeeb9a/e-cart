// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
    String? type;
    String? message;
    List<dynamic>? transactions;

    TransactionModel({
        this.type,
        this.message,
        this.transactions,
    });

    factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
        type: json["type"],
        message: json["message"],
        transactions: json["transactions"] == null ? [] : List<dynamic>.from(json["transactions"]!.map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "transactions": transactions == null ? [] : List<dynamic>.from(transactions!.map((x) => x)),
    };
}
