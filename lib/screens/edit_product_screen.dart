import 'dart:io';

import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/screens/my_products_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/constants/data.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/categories_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  Product product;
  EditProductScreen({Key key, @required this.product}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final ImagePicker _picker = ImagePicker();

  int selectedCategory;
  String name = "";
  String description = "";
  num price = 0;

  String dropdownvalue = 'Sofas';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // selectedCategory = widget.product.categoryId;
  }

  String imageFile = "";
  XFile displayImage;
  bool gotTheImage = false;

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    name = widget.product.name;
    description = widget.product.description;
    price = widget.product.price;
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(
        title: prefProvider.language == Languages.en
            ? "Edit Product"
            : "تعديل المنتج",
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
              child: TextFormField(
                initialValue: widget.product.name,
                onChanged: (value) {
                  setState(() {
                    widget.product.name = value;
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
              child: TextFormField(
                initialValue: widget.product.description,
                onChanged: (value) {
                  setState(() {
                    widget.product.description = value;
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
              child: TextFormField(
                initialValue: widget.product.price.toString(),
                onChanged: (value) {
                  setState(() {
                    widget.product.price = num.parse(value);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: prefProvider.language == Languages.en
                      ? "Price "
                      : "السعر",
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15),
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
                value: widget.product.categoryId,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: allCategories.map((Category value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.product.categoryId = value;
                  });
                },
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(primaryColor),
                ),
                child: Text(
                  prefProvider.language == Languages.en ? "Update" : "تثبيت",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Product product = Product(
                    id: widget.product.id,
                    description: description,
                    name: name,
                    price: price,
                    isSold: widget.product.isSold,
                    userId: user.id,
                    categoryId: selectedCategory == widget.product.categoryId
                        ? selectedCategory
                        : widget.product.categoryId,
                    imageToSend2: imageFile != "" ? imageFile : "null",
                  );
                  Provider.of<ProductsProvider>(context, listen: false)
                      .updateProduct(product)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => HomeScreen()),
                      ModalRoute.withName('/'),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MyProductsScreen(),
                      ),
                    );
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
