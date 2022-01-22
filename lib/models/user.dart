// import 'dart:convert';

class User {
  User({
    this.id,
    this.username,
    this.address,
    this.phone,
    this.email,
    this.password,
    this.image,
    this.isAdmin,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String username;
  dynamic address;
  dynamic phone;
  String email;
  String password;
  dynamic image;
  dynamic isAdmin;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        image: json["image"],
        isAdmin: json["isAdmin"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "address": address,
        "phone": phone,
        "email": email,
        "password": password,
        "image": image,
        "isAdmin": isAdmin,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Users {
  final List<dynamic> userList;

  Users({this.userList});

  factory Users.fromjson(List<dynamic> jsonData) {
    return Users(
      userList: jsonData,
    );
  }
}
