import 'dart:io';

import 'package:first_app/constants/colors.dart';
import 'package:first_app/constants/data.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final ImagePicker _picker = ImagePicker();

  int selectedCategory = 1;
  String name = "any";
  String description = "any";
  double price = 0;
  String imageFile;

  XFile displayImage;
  bool gotTheImage = false;

  String dropdownvalue = 'Sofas';
  List<String> items = [
    'Sofas',
    'Couches',
    'Assault Rifle',
  ];
  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(
        title: prefProvider.language == Languages.en
            ? "Add Product"
            : "اضافة منتج",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                XFile image =
                    await _picker.pickImage(source: ImageSource.gallery);
                displayImage = image;
                imageFile = image.path;
                setState(() {
                  gotTheImage = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  // image: DecorationImage(image: MemoryImage(displayImage.path)),
                  border: Border.all(
                    color: Colors.white,
                  ),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                height: 200.0,
                width: width,
                child: gotTheImage == false
                    ? Icon(
                        Icons.add,
                        color: primaryColor,
                        size: 50.0,
                      )
                    : Image.file(
                        File(displayImage.path),
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    this.name = value;
                  });
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText: prefProvider.language == Languages.en
                      ? "Product Name"
                      : "اسم المنتج",
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    this.description = value;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 6,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText: prefProvider.language == Languages.en
                      ? "Description"
                      : "الوصف",
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    this.price = double.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.only(
                      left: 15, bottom: 11, top: 11, right: 15),
                  hintText: prefProvider.language == Languages.en
                      ? "Price "
                      : "السعر",
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: DropdownButton<int>(
                underline: DropdownButtonHideUnderline(child: Container()),
                isExpanded: true,
                value: selectedCategory,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: allCategories.map((Category value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
            ),
            Container(
              width: width,
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextButton(
                style: ButtonStyle(
                  // padding: EdgeInsets.zero,
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
                child: Text(
                  prefProvider.language == Languages.en ? "Add" : "اضافة",
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  Product product = Product(
                    description: description,
                    name: name,
                    price: price,
                    isSold: 0,
                    userId: user.id,
                    categoryId: selectedCategory,
                    imageToSend2: imageFile,
                  );
                  Provider.of<ProductsProvider>(context, listen: false)
                      .addProduct(product)
                      .then((value) {
                    if (value == "allow") {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => HomeScreen()),
                        ModalRoute.withName('/'),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          content: Text(
                            prefProvider.language == Languages.en
                                ? "Product violates our terms of service."
                                : "لم يتم السماح بتثبيت المنتج لأنه يخالف شروط الاستخدام",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ), //here
    );
  }
}
