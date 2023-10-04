// To parse this JSON data, do
//
//     final assignedDriverOrdersModel = assignedDriverOrdersModelFromJson(jsonString);

import 'dart:convert';

AssignedDriverOrdersModel assignedDriverOrdersModelFromJson(String str) =>
    AssignedDriverOrdersModel.fromJson(json.decode(str));

String assignedDriverOrdersModelToJson(AssignedDriverOrdersModel data) =>
    json.encode(data.toJson());

class AssignedDriverOrdersModel {
  String? type;
  String? message;
  List<Order>? orders;

  AssignedDriverOrdersModel({
    this.type,
    this.message,
    this.orders,
  });

  factory AssignedDriverOrdersModel.fromJson(Map<String, dynamic> json) =>
      AssignedDriverOrdersModel(
        type: json["type"],
        message: json["message"],
        orders: json["orders"] == null
            ? []
            : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "orders": orders == null
            ? []
            : List<dynamic>.from(orders!.map((x) => x.toJson())),
      };
}

class Order {
  dynamic couponId;
  String? id;
  List<Product>? products;
  String? user;
  int? totalPrice;
  bool? isPaid;
  DateTime? paidAt;
  bool? isDelivered;
  ShippingAddress? shippingAddress;
  String? paymentMethod;
  int? taxPrice;
  int? shippingPrice;
  String? phone;
  String? status;
  String? transactionId;
  String? driver;
  int? driverOtp;
  List<OrderTracking>? orderTracking;

  Order({
    this.couponId,
    this.id,
    this.products,
    this.user,
    this.totalPrice,
    this.isPaid,
    this.paidAt,
    this.isDelivered,
    this.shippingAddress,
    this.paymentMethod,
    this.taxPrice,
    this.shippingPrice,
    this.phone,
    this.status,
    this.transactionId,
    this.driver,
    this.driverOtp,
    this.orderTracking,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        couponId: json["coupon_id"],
        id: json["_id"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        user: json["user"],
        totalPrice: json["totalPrice"],
        isPaid: json["isPaid"],
        paidAt: json["paidAt"] == null ? null : DateTime.parse(json["paidAt"]),
        isDelivered: json["isDelivered"],
        shippingAddress: json["shippingAddress"] == null
            ? null
            : ShippingAddress.fromJson(json["shippingAddress"]),
        paymentMethod: json["paymentMethod"],
        taxPrice: json["taxPrice"],
        shippingPrice: json["shippingPrice"],
        phone: json["phone"],
        status: json["status"],
        transactionId: json["transactionId"],
        driver: json["driver"],
        driverOtp: json["driver_otp"],
        orderTracking: json["orderTracking"] == null
            ? []
            : List<OrderTracking>.from(
                json["orderTracking"]!.map((x) => OrderTracking.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "coupon_id": couponId,
        "_id": id,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "user": user,
        "totalPrice": totalPrice,
        "isPaid": isPaid,
        "paidAt": paidAt?.toIso8601String(),
        "isDelivered": isDelivered,
        "shippingAddress": shippingAddress?.toJson(),
        "paymentMethod": paymentMethod,
        "taxPrice": taxPrice,
        "shippingPrice": shippingPrice,
        "phone": phone,
        "status": status,
        "transactionId": transactionId,
        "driver": driver,
        "driver_otp": driverOtp,
        "orderTracking": orderTracking == null
            ? []
            : List<dynamic>.from(orderTracking!.map((x) => x.toJson())),
      };
}

class OrderTracking {
  String? status;
  DateTime? trackingDate;
  String? id;

  OrderTracking({
    this.status,
    this.trackingDate,
    this.id,
  });

  factory OrderTracking.fromJson(Map<String, dynamic> json) => OrderTracking(
        status: json["status"],
        trackingDate: json["trackingDate"] == null
            ? null
            : DateTime.parse(json["trackingDate"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "trackingDate": trackingDate?.toIso8601String(),
        "_id": id,
      };
}

class Product {
  ProductInfo? productInfo;
  String? product;
  dynamic selectedColor;
  dynamic selectedSize;
  int? totalProductQuantity;
  int? totalProductPrice;
  String? id;

  Product({
    this.productInfo,
    this.product,
    this.selectedColor,
    this.selectedSize,
    this.totalProductQuantity,
    this.totalProductPrice,
    this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productInfo: json["productInfo"] == null
            ? null
            : ProductInfo.fromJson(json["productInfo"]),
        product: json["product"],
        selectedColor: json["selectedColor"],
        selectedSize: json["selectedSize"],
        totalProductQuantity: json["totalProductQuantity"],
        totalProductPrice: json["totalProductPrice"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "productInfo": productInfo?.toJson(),
        "product": product,
        "selectedColor": selectedColor,
        "selectedSize": selectedSize,
        "totalProductQuantity": totalProductQuantity,
        "totalProductPrice": totalProductPrice,
        "_id": id,
      };
}

class ProductInfo {
  MainImage? mainImage;
  String? name;
  int? price;
  String? slug;
  Seller? seller;

  ProductInfo({
    this.mainImage,
    this.name,
    this.price,
    this.slug,
    this.seller,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        mainImage: json["mainImage"] == null
            ? null
            : MainImage.fromJson(json["mainImage"]),
        name: json["name"],
        price: json["price"],
        slug: json["slug"],
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
      );

  Map<String, dynamic> toJson() => {
        "mainImage": mainImage?.toJson(),
        "name": name,
        "price": price,
        "slug": slug,
        "seller": seller?.toJson(),
      };
}

class MainImage {
  String? original;
  String? web;
  String? mobile;
  String? id;

  MainImage({
    this.original,
    this.web,
    this.mobile,
    this.id,
  });

  factory MainImage.fromJson(Map<String, dynamic> json) => MainImage(
        original: json["original"],
        web: json["web"],
        mobile: json["mobile"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "web": web,
        "mobile": mobile,
        "_id": id,
      };
}

class Seller {
  String? id;
  String? name;

  Seller({
    this.id,
    this.name,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class ShippingAddress {
  Location? location;
  String? firstName;
  String? lastName;
  String? email;
  Phone? phone;
  String? address;
  String? city;
  String? zipCode;
  String? country;
  String? id;

  ShippingAddress({
    this.location,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.address,
    this.city,
    this.zipCode,
    this.country,
    this.id,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"] == null ? null : Phone.fromJson(json["phone"]),
        address: json["address"],
        city: json["city"],
        zipCode: json["zipCode"],
        country: json["country"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone?.toJson(),
        "address": address,
        "city": city,
        "zipCode": zipCode,
        "country": country,
        "_id": id,
      };
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Phone {
  String? code;
  String? number;
  String? id;

  Phone({
    this.code,
    this.number,
    this.id,
  });

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
        code: json["code"],
        number: json["number"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "number": number,
        "_id": id,
      };
}
