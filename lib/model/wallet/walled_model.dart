// To parse this JSON data, do
//
//     final walletModel = walletModelFromJson(jsonString);

import 'dart:convert';

WalletModel walletModelFromJson(String str) =>
    WalletModel.fromJson(json.decode(str));

String walletModelToJson(WalletModel data) => json.encode(data.toJson());

class WalletModel {
  String? type;
  String? message;
  Wallet? wallet;
  int? completedOrders;

  WalletModel({
    this.type,
    this.message,
    this.wallet,
    this.completedOrders,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
        type: json["type"],
        message: json["message"],
        wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
        completedOrders: json["completed_orders"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "wallet": wallet?.toJson(),
        "completed_orders": completedOrders,
      };
}

class Wallet {
  String? id;
  String? userId;
  String? walletType;
  int? balance;
  int? withdrawAmount;

  Wallet({
    this.id,
    this.userId,
    this.walletType,
    this.balance,
    this.withdrawAmount,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        id: json["_id"],
        userId: json["userId"],
        walletType: json["wallet_type"],
        balance: json["balance"],
        withdrawAmount: json["withdraw_amount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "wallet_type": walletType,
        "balance": balance,
        "withdraw_amount": withdrawAmount,
      };
}
