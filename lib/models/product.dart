// To parse this JSON data, do
//
//     final product = welcomeFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:first_app/models/category.dart';
import 'package:first_app/models/user.dart';
import 'package:image_picker/image_picker.dart';

// import 'package:sellit/models/user.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.price,
    this.userId,
    this.categoryId,
    this.isSold,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.imageToSend,
    this.imageToSend2,
    this.category,
  });

  int id;
  String name;
  dynamic description;
  dynamic price;
  int userId;
  dynamic categoryId;
  dynamic isSold;
  String image;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  File imageToSend;
  String imageToSend2;
  Category category;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        isSold: json["isSold"],
        image: json['image'],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        user: User.fromJson(json["user"]),
        category: json['category'] != null
            ? Category.fromJson(json['category'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "userId": userId,
        "categoryId": categoryId,
        "isSold": isSold,
      };
}

class Products {
  final List<dynamic> productList;

  Products({this.productList});

  factory Products.fromjson(List<dynamic> jsonData) {
    return Products(
      productList: jsonData,
    );
  }
}
