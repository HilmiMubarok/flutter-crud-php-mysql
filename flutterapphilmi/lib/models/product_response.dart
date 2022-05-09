// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.itemCode,
    this.itemName,
    this.price,
    this.stock,
  });

  String? id;
  String? itemCode;
  String? itemName;
  String? price;
  String? stock;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        itemCode: json["item_code"],
        itemName: json["item_name"],
        price: json["price"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_code": itemCode,
        "item_name": itemName,
        "price": price,
        "stock": stock,
      };
}
