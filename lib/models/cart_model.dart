// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

import 'package:food_delivery/models/products_model.dart';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  int id;
  String name;
  int price;
  String img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductElement? product;

  CartModel({
    required this.id,
    required this.name,
    required this.price,
    required this.img,
    this.quantity,
    this.isExist,
    this.time,
    this.product,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        img: json["img"],
        quantity: json["quantity"],
        isExist: json["isExist"],
        time: json["time"],
        product: json["product"] == null
            ? null
            : ProductElement.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "img": img,
        "quantity": quantity,
        "isExist": isExist,
        "time": time,
        "product": product == null ? null : product!.toJson(),
      };
}
