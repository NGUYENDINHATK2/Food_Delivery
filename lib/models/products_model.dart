// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductElement> _products;
  List<ProductElement> get products => _products;

  Product({
    required totalSize,
    required typeId,
    required offset,
    required products,
  }) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _products = products;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        totalSize: json["total_size"],
        typeId: json["type_id"],
        offset: json["offset"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_size": _totalSize,
        "type_id": _typeId,
        "offset": _offset,
        "products": List<dynamic>.from(_products.map((x) => x.toJson())),
      };
}

class ProductElement {
  int id;
  String name;
  String description;
  int price;
  int stars;
  String img;
  String location;
  String createdAt;
  String updatedAt;
  int typeId;

  ProductElement({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stars,
    required this.img,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.typeId,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stars: json["stars"],
        img: json["img"],
        location: json["location"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        typeId: json["type_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stars": stars,
        "img": img,
        "location": location,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "type_id": typeId,
      };
}
