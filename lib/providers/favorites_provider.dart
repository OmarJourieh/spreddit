import 'dart:convert';

import 'package:first_app/constants/api.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoritesProvider extends ChangeNotifier {
  Future<void> getAllFavorites(int userId) async {
    // for (int i = 0; i < 100; i++) {
    //   print(userId);
    // }
    var res = await http.get(
      Uri.parse('$API/getallfavorites/' + userId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var jsonData = jsonDecode(data);
      Products products = Products.fromjson(jsonData);
      List<Product> pList =
          products.productList.map((e) => Product.fromJson(e)).toList();
      // items = bList;

      return pList;
    } else {
      print("statusCode=${res.statusCode}");
      List<Product> empty = [];
      return empty;
    }
  }

  Future<List<int>> getfavoritesids(int userId) async {
    var res = await http.get(
      Uri.parse('$API/getfavoritesids/' + userId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      List<dynamic> jsonData = jsonDecode(data);
      List<int> intList2 = jsonData.cast<int>();
      return intList2;
    } else {
      print("statusCode=${res.statusCode}");
      List<int> empty = [];
      return empty;
    }
  }

  Future<void> removeFromFavorites(int userId, int productId) async {
    RequestData rd = RequestData(userId: userId, productId: productId);
    http.Response res = await http.post(
      Uri.parse("$API/deleteformfavorite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rd),
    );
    notifyListeners();
  }

  Future<void> addToFavorites(int userId, int productId) async {
    RequestData rd = RequestData(userId: userId, productId: productId);
    http.Response res = await http.post(
      Uri.parse("$API/addtofavorite"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(rd),
    );
    notifyListeners();
  }
}

class RequestData {
  int userId;
  int productId;

  RequestData({this.userId, this.productId});

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "product_id": productId,
      };
}
