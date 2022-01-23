import 'package:first_app/screens/category_products_screen.dart';
import 'package:first_app/screens/history_screen.dart';
import 'package:first_app/screens/my_profile_screen.dart';
import 'package:first_app/screens/redone_conv_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/conversation_screen.dart';
import 'package:first_app/screens/edit_product_screen.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  final int id;
  final String name;
  const ProductScreen({Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: getAppBar(title: name),
      body: FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false)
            .getSingleProduct(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * 0.4,
                      decoration: BoxDecoration(
                        color: color3,
                        image: DecorationImage(
                          // image: AssetImage("assets/images/product.jfif"),
                          image: snapshot.data.image != null
                              ? NetworkImage(imagesRoot + snapshot.data.image)
                              : const AssetImage("assets/images/p1.png"),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Description:",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Expanded(child: Center()),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  snapshot.data.description,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Expanded(
                                child: Text(
                                  "Price:",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Expanded(child: Center()),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "${snapshot.data.price}  s.p.",
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategoryProductsScreen(
                                    id: snapshot.data.category.id,
                                    name: snapshot.data.category.name,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Category:",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Center()),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "${snapshot.data.category.name}",
                                    style: const TextStyle(
                                      // color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 40),
                          GestureDetector(
                            onTap: () {
                              print(snapshot.data.user.id);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => MyProfileScreen(
                                        user: snapshot.data.user)),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Expanded(
                                  child: Text(
                                    "Owner:",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Center()),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    // "owner",
                                    snapshot.data.user.username,
                                    style: const TextStyle(
                                      // color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 40),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: user.id == snapshot.data.user.id
                          ? snapshot.data.isSold != 1
                              ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EditProductScreen(
                                                  product: snapshot.data,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text(
                                            "Edit",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    primaryColor),
                                            padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                  horizontal: 60.0),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteProduct(snapshot.data.id)
                                                .then((value) {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HomeScreen()),
                                                ModalRoute.withName('/'),
                                              );
                                            });
                                          },
                                          child: const Text(
                                            "Delete",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.redAccent),
                                            padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  vertical: 20.0,
                                                  horizontal: 60.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextButton(
                                            onPressed: () {
                                              Provider.of<ProductsProvider>(
                                                      context,
                                                      listen: false)
                                                  .markAsSold(snapshot.data.id)
                                                  .then((value) {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomeScreen()),
                                                  ModalRoute.withName('/'),
                                                );
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        HistoryScreen(),
                                                  ),
                                                );
                                              });
                                            },
                                            child: const Text(
                                              "Mark as Sold",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.green[400]),
                                              padding:
                                                  MaterialStateProperty.all(
                                                const EdgeInsets.symmetric(
                                                    vertical: 20.0,
                                                    horizontal: 60.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {},
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          // size: 100.0,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.green[400]),
                                          padding: MaterialStateProperty.all(
                                            const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 60.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                          : Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      // await Provider.of<MessagesProvider>(context,
                                      //         listen: false)
                                      //     .sendMessage(
                                      //   content: "MESSAGE REGARDING " +
                                      //       snapshot.data.name,
                                      //   senderId: user.id,
                                      //   receiverId: snapshot.data.user.id,
                                      // );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => ConversationScreen(
                                            receivingUser: snapshot.data.user,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Contact Owner",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              primaryColor),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 60.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
