import 'dart:convert';

import 'package:first_app/constants/api.dart';
import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsProvider extends ChangeNotifier {
  List<Product> allProducts = [];
  Product product;

  // Future<List<Product>> getAllProducts() async {
  Future<List<Product>> getAllProducts() async {
    var res = await http.get(
      Uri.parse('$API/getallproducts'),
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

  Future<Product> getSingleProduct(int id) async {
    var res = await http.get(
      Uri.parse('$API/getproductbyid/' + id.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
    product = Product.fromJson(jsonDecode(res.body));
    notifyListeners();
    return Product.fromJson(jsonDecode(res.body));
  }

  Future<List<Product>> getAllProductsOfUser(int id) async {
    var res = await http.get(
      Uri.parse('$API/getallproductsofuser/' + id.toString()),
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

  Future<void> addProduct2(Product product) async {
    http.Response res = await http.post(
      Uri.parse("$API/addproduct"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(product),
    );

    notifyListeners();
  }

  Future<String> addProduct(Product product) async {
    // http.MultipartRequest mlRequest =
    //     http.MultipartRequest("POST", Uri.parse("http://192.168.43.128:5000/"));
    // http.MultipartFile multipartFile2 =
    //     await http.MultipartFile.fromPath('image', product.imageToSend2);
    // mlRequest.files.add(multipartFile2);
    // http.StreamedResponse mlResponse = await mlRequest.send();
    // var RES = await http.Response.fromStream(mlResponse);
    // if (RES.body == "1") {
    //   return "deny";
    // }

    http.MultipartRequest request =
        http.MultipartRequest("POST", Uri.parse("$API/addproduct"));

    http.MultipartFile multipartFile =
        await http.MultipartFile.fromPath('image', product.imageToSend2);

    request.files.add(multipartFile);

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['userId'] = product.userId.toString();
    request.fields['categoryId'] = product.categoryId.toString();
    request.fields['isSold'] = 0.toString();

    http.StreamedResponse response = await request.send();

    notifyListeners();

    return "allow";
  }

  Future<void> markAsSold(int productId) async {
    var res = await http.get(
      Uri.parse('$API/markproductsold/' + productId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
  }

  Future<void> deleteProduct(int productId) async {
    var res = await http.get(
      Uri.parse('$API/deleteproduct/' + productId.toString()),
      headers: {
        "Accept": "application/json",
        "Access-Control_Allow_Origin": "*"
      },
    );
  }

  Future<void> updateProduct(Product product) async {
    http.MultipartRequest request = http.MultipartRequest(
        "POST", Uri.parse("$API/updateproduct/${product.id}"));

    if (product.imageToSend2 != 'null') {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('image', product.imageToSend2);
      request.files.add(multipartFile);
    }

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['userId'] = product.userId.toString();
    request.fields['categoryId'] = product.categoryId.toString();
    request.fields['isSold'] = product.isSold.toString();

    http.StreamedResponse response = await request.send();

    // http.Response res = await http.post(
    //   Uri.parse("$API/updateproduct/" + product.id.toString()),
    //   headers: <String, String>{
    //     'Content-Type': 'application/json; charset=UTF-8',
    //   },
    //   body: jsonEncode(product),
    // );
    // notifyListeners();
  }

  Future<void> updateProduct2(Product product) async {
    http.MultipartRequest request = new http.MultipartRequest(
        "POST", Uri.parse("$API/updateproduct/" + product.id.toString()));

    if (product.imageToSend2 != 'null') {
      http.MultipartFile multipartFile =
          await http.MultipartFile.fromPath('image', product.imageToSend2);
      request.files.add(multipartFile);
    }

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();
    request.fields['userId'] = product.userId.toString();
    request.fields['categoryId'] = product.categoryId.toString();
    request.fields['isSold'] = product.isSold.toString();

    http.StreamedResponse response = await request.send();
    notifyListeners();
  }
}
