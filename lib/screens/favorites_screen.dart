import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/favorites_provider.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:first_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class FavortiesScreen extends StatefulWidget {
  const FavortiesScreen({Key key}) : super(key: key);

  @override
  _FavortiesScreenState createState() => _FavortiesScreenState();
}

class _FavortiesScreenState extends State<FavortiesScreen> {
  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(user.email);
    print(user.address);
    print(user.password);
    print(user.password);
    print(user.password);
    print(user.password);
    print(user.password);
    print(user.password);
    print(user.password);
    print(user.password);
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(title: "Favorites"),
      bottomNavigationBar: BottomNavBar(),
      drawer: getDrawer(height: height, width: width, context: context),
      body: FutureBuilder(
        future: Provider.of<FavoritesProvider>(context, listen: false)
            .getAllFavorites(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext ctx, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProductScreen(
                            id: snapshot.data[index].id,
                            name: snapshot.data[index].name,
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
                                    image: snapshot.data[index].image != null
                                        ? NetworkImage(imagesRoot +
                                            snapshot.data[index].image)
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
                                        snapshot.data[index].name.length <= 15
                                            ? snapshot.data[index].name
                                            : snapshot.data[index].name
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
                                        snapshot.data[index].price.toString() +
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
                            onPressed: () {
                              setState(() {
                                Provider.of<FavoritesProvider>(context,
                                        listen: false)
                                    .removeFromFavorites(
                                        user.id, snapshot.data[index].id);
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
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
