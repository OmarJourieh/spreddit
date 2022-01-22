import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/categories_provider.dart';
import 'package:first_app/providers/favorites_provider.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int id;
  final String name;
  const CategoryProductsScreen({Key key, this.id, this.name}) : super(key: key);

  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: color3,
      appBar: getAppBar(title: widget.name),
      body: FutureBuilder(
        future: Future.wait([
          Provider.of<CategoriesProvider>(context, listen: false)
              .getProductsByCategory(widget.id),
          Provider.of<FavoritesProvider>(context, listen: false)
              .getfavoritesids(user.id)
        ]),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              List<Product> filteredList =
                  snapshot.data[0].where((i) => i.isSold != 1).toList();
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: filteredList.length,
                itemBuilder: (BuildContext ctx, index) {
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
                                    image: filteredList[index].image != null
                                        ? NetworkImage(imagesRoot +
                                            filteredList[index].image)
                                        : AssetImage("assets/images/p1.png"),
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
                                        snapshot.data[0][index].name.length <=
                                                17
                                            ? snapshot.data[0][index].name
                                            : snapshot.data[0][index].name
                                                    .substring(0, 17) +
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
                                        snapshot.data[0][index].price
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
                                      Provider.of<FavoritesProvider>(context,
                                              listen: false)
                                          .removeFromFavorites(
                                              user.id, filteredList[index].id);
                                    });
                                  }
                                : () {
                                    setState(() {
                                      Provider.of<FavoritesProvider>(context,
                                              listen: false)
                                          .addToFavorites(
                                              user.id, filteredList[index].id);
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
    );
  }
}
