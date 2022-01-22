import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/constants/data.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/favorites_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/add_product.dart';
import 'package:first_app/screens/my_search_screen.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:first_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedCategory = 0;
  List<Category> modifiedCategories = List.from(allCategories);
  @override
  Widget build(BuildContext context) {
    print(modifiedCategories.length);
    print(allCategories.length);
    if (modifiedCategories.length != (allCategories.length + 1)) {
      modifiedCategories.insert(0, Category(id: 0, name: "All", image: ""));
    }
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: color3,
      drawer: getDrawer(height: height, width: width, context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddProductScreen()),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: primaryColor,
          // elevation: 0,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      appBar: getAppBar(
          hasSearch: true,
          callback: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => MySearchScreen()));
          }),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
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
            child: DropdownButton<int>(
              underline: DropdownButtonHideUnderline(child: Container()),
              isExpanded: true,
              value: selectedCategory,
              icon: Icon(Icons.keyboard_arrow_down),
              items: modifiedCategories.map((Category value) {
                print("Category ID: " + selectedCategory.toString());
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
          SizedBox(
            height: height * 0.8,
            child: FutureBuilder(
              future: Future.wait([
                Provider.of<ProductsProvider>(context, listen: false)
                    .getAllProducts(),
                Provider.of<FavoritesProvider>(context, listen: false)
                    .getfavoritesids(user.id)
              ]),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                //    snapshot.data[0];
                //    snapshot.data[1];
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  if (snapshot.hasError)
                    return Center(child: Text('Error: ${snapshot.error}'));
                  else {
                    // print(snapshot.data[0]);
                    List<Product> filteredList = [];
                    if (selectedCategory != 0) {
                      filteredList = snapshot.data[0]
                          .where((i) =>
                              i.isSold != 1 && i.categoryId == selectedCategory)
                          .toList();
                    } else {
                      filteredList =
                          snapshot.data[0].where((i) => i.isSold != 1).toList();
                    }

                    // print(filteredList);
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemCount: filteredList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        // List<int> favs = [-1];
                        // favs = favs + snapshot2.data;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ProductScreen(
                                  id: filteredList[index].id,
                                  name: filteredList[index].name,
                                ),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        image: DecorationImage(
                                          // image: NetworkImage(snapshot.data[index].image),
                                          // image: AssetImage(
                                          //     "assets/images/product.jfif"),
                                          image:
                                              filteredList[index].image != null
                                                  ? NetworkImage(imagesRoot +
                                                      filteredList[index].image)
                                                  : AssetImage(
                                                      "assets/images/p1.png"),

                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      // SizedBox(height: height * 0.002),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: height * 0.005,
                                          horizontal: width * 0.02,
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              filteredList[index].name.length <=
                                                      15
                                                  ? filteredList[index].name
                                                  : filteredList[index]
                                                          .name
                                                          .substring(0, 15) +
                                                      "...",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            // Text(filteredList[index]
                                            //         .price
                                            //         .toString() +
                                            //     " s.p."),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.2),
                                          // borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      // SizedBox(height: height * 0.002),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: height * 0.005,
                                          horizontal: width * 0.02,
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Text(filteredList[index].name),
                                            // Expanded(child: Center()),
                                            Text(
                                              filteredList[index]
                                                      .price
                                                      .toString() +
                                                  " s.p.",
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                          color: primaryColor.withOpacity(0.2),
                                          // borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: IconButton(
                                  onPressed: snapshot.data[1]
                                          .contains(filteredList[index].id)
                                      ? () {
                                          setState(() {
                                            Provider.of<FavoritesProvider>(
                                                    context,
                                                    listen: false)
                                                .removeFromFavorites(user.id,
                                                    filteredList[index].id);
                                          });
                                        }
                                      : () {
                                          setState(() {
                                            Provider.of<FavoritesProvider>(
                                                    context,
                                                    listen: false)
                                                .addToFavorites(user.id,
                                                    filteredList[index].id);
                                          });
                                        },
                                  icon: snapshot.data[1]
                                          .contains(filteredList[index].id)
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: Colors.red,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
