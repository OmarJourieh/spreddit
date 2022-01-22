import 'package:first_app/constants/colors.dart';
import 'package:first_app/providers/categories_provider.dart';
import 'package:first_app/screens/category_products_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:first_app/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(title: "Categories"),
      bottomNavigationBar: BottomNavBar(),
      drawer: getDrawer(height: height, width: width, context: context),
      body: FutureBuilder(
        future: Provider.of<CategoriesProvider>(context, listen: false)
            .getAllCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsScreen(
                            id: snapshot.data[index].id,
                            name: snapshot.data[index].name,
                          ),
                        ),
                      );
                    },
                    child: getCategoryWidget(
                      categoryName: snapshot.data[index].name,
                      categoryImage: snapshot.data[index].image,
                      snapshot: snapshot,
                      index: index,
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

Widget getCategoryWidget({categoryName, categoryImage, snapshot, index}) {
  return Column(
    children: [
      SizedBox(
        height: 10.0,
      ),
      Container(
        height: 200.0,
        width: 200.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(2000.0),
          ),
          image: DecorationImage(
            // image: AssetImage(categoryImage),
            image: snapshot.data[index].image != null
                ? NetworkImage(snapshot.data[index].image)
                : AssetImage("assets/images/p2.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      Text(
        categoryName,
        // style: TextStyle(color: primaryColor),
      ),
      SizedBox(
        height: 5.0,
      ),
    ],
  );
}
