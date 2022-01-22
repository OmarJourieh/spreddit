import 'dart:convert';

import 'package:first_app/constants/api.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  Future<List<Category>> getAllCategories() async {
    var res = await http.get(
      Uri.parse('$API/getallcategories'),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    if (res.statusCode == 200) {
      String data = res.body;
      var jsonData = jsonDecode(data);
      Categories categories = Categories.fromjson(jsonData);
      List<Category> cList =
          categories.catList.map((e) => Category.fromJson(e)).toList();
      // items = bList;
      return cList;
    } else {
      print("statusCode=${res.statusCode}");
      List<Category> empty = [];
      return empty;
    }
  }

  Future<Category> getSingleCategory(int id) async {
    var res = await http.get(
      Uri.parse('$API/getcategorybyid' + id.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );

    return Category.fromJson(jsonDecode(res.body));
  }

  Future<List<Product>> getProductsByCategory(int id) async {
    var res = await http.get(
      Uri.parse('$API/getproductsbycategory/' + id.toString()),
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
}
