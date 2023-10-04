// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? type;
  String? message;
  User? user;
  Tokens? tokens;

  LoginModel({
    this.type,
    this.message,
    this.user,
    this.tokens,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? chatToken;
  String? password;
  String? role;
  bool? isEmailVerified;
  bool? isVerifiedSeller;
  bool? isVerifiedDriver;
  int? taxPercentage;
  List<dynamic>? kycDocuments;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.chatToken,
    this.password,
    this.role,
    this.isEmailVerified,
    this.isVerifiedSeller,
    this.isVerifiedDriver,
    this.taxPercentage,
    this.kycDocuments,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        chatToken: json["chat_token"],
        password: json["password"],
        role: json["role"],
        isEmailVerified: json["isEmailVerified"],
        isVerifiedSeller: json["isVerifiedSeller"],
        isVerifiedDriver: json["isVerifiedDriver"],
        taxPercentage: json["tax_percentage"],
        kycDocuments: json["kyc_documents"] == null
            ? []
            : List<dynamic>.from(json["kyc_documents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "chat_token": chatToken,
        "password": password,
        "role": role,
        "isEmailVerified": isEmailVerified,
        "isVerifiedSeller": isVerifiedSeller,
        "isVerifiedDriver": isVerifiedDriver,
        "tax_percentage": taxPercentage,
        "kyc_documents": kycDocuments == null
            ? []
            : List<dynamic>.from(kycDocuments!.map((x) => x)),
      };
}
