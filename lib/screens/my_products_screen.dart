import 'package:first_app/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/add_product.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:provider/provider.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBody: true,
      backgroundColor: color3,
      appBar: getAppBar(
          title: prefProvider.language == Languages.en
              ? "My Products"
              : "منتجاتي"),
      body: FutureBuilder(
        //1
        future: Provider.of<ProductsProvider>(context, listen: false)
            .getAllProductsOfUser(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              List<Product> filteredList =
                  snapshot.data.where((i) => i.isSold != 1).toList();
              // print(filteredList[0].name);
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
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                // image: NetworkImage(filteredList[index].image),
                                image: filteredList[index].image != null
                                    ? NetworkImage(
                                        imagesRoot + filteredList[index].image)
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
                                    filteredList[index].name.length <= 17
                                        ? filteredList[index].name
                                        : filteredList[index]
                                                .name
                                                .substring(0, 17) +
                                            "...",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                    filteredList[index].price.toString() +
                                        " s.p.",
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
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
                  );
                },
              );
            } //4
          } //3
        }, //2
      ), //1
    );
  }
}
