// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String? type;
  String? message;
  User? user;
  Tokens? tokens;

  SignupModel({
    this.type,
    this.message,
    this.user,
    this.tokens,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        type: json["type"],
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokens: json["tokens"] == null ? null : Tokens.fromJson(json["tokens"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "user": user?.toJson(),
        "tokens": tokens?.toJson(),
      };
}

class Tokens {
  String? accessToken;
  String? refreshToken;

  Tokens({
    this.accessToken,
    this.refreshToken,
  });

  factory Tokens.fromJson(Map<String, dynamic> json) => Tokens(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? chatToken;
  String? role;
  bool? isEmailVerified;
  bool? isVerifiedSeller;
  bool? isVerifiedDriver;
  int? taxPercentage;
  List<dynamic>? kycDocuments;
  String? id;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.chatToken,
    this.role,
    this.isEmailVerified,
    this.isVerifiedSeller,
    this.isVerifiedDriver,
    this.taxPercentage,
    this.kycDocuments,
    this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        chatToken: json["chat_token"],
        role: json["role"],
        isEmailVerified: json["isEmailVerified"],
        isVerifiedSeller: json["isVerifiedSeller"],
        isVerifiedDriver: json["isVerifiedDriver"],
        taxPercentage: json["tax_percentage"],
        kycDocuments: json["kyc_documents"] == null
            ? []
            : List<dynamic>.from(json["kyc_documents"]!.map((x) => x)),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "chat_token": chatToken,
        "role": role,
        "isEmailVerified": isEmailVerified,
        "isVerifiedSeller": isVerifiedSeller,
        "isVerifiedDriver": isVerifiedDriver,
        "tax_percentage": taxPercentage,
        "kyc_documents": kycDocuments == null
            ? []
            : List<dynamic>.from(kycDocuments!.map((x) => x)),
        "_id": id,
      };
}
