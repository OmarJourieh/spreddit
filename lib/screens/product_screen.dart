import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/screens/category_products_screen.dart';
import 'package:first_app/screens/history_screen.dart';
import 'package:first_app/screens/my_profile_screen.dart';
import 'package:first_app/screens/redone_conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/providers/products_provider.dart';
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
    var prefProvider = Provider.of<PreferencesProvider>(context);
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
              print(snapshot.data);
              print(snapshot.data);
              print(snapshot.data);
              print(snapshot.data);
              print(snapshot.data);
              print(snapshot.data.name);
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
                              Expanded(
                                child: Text(
                                  prefProvider.language == Languages.en
                                      ? "Description:"
                                      : "الوصف:",
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
                              Expanded(
                                child: Text(
                                  prefProvider.language == Languages.en
                                      ? "Price:"
                                      : "السعر:",
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const Expanded(child: Center()),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  prefProvider.language == Languages.en
                                      ? "${snapshot.data.price}  s.p."
                                      : "${snapshot.data.price} ل.س.",
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
                                Expanded(
                                  child: Text(
                                    prefProvider.language == Languages.en
                                        ? "Category:"
                                        : "الصنف:",
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
                                Expanded(
                                  child: Text(
                                    prefProvider.language == Languages.en
                                        ? "Owner:"
                                        : "المالك:",
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
                                          child: Text(
                                            prefProvider.language ==
                                                    Languages.en
                                                ? "Edit"
                                                : "تعديل",
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
                                            showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                content: Text(
                                                  prefProvider.language ==
                                                          Languages.en
                                                      ? "Are you sure you want to delete this product?"
                                                      : "هل انت متأكد انك تريد حذف هذا المنتج؟",
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text(
                                                        prefProvider.language ==
                                                                Languages.en
                                                            ? "Cancel"
                                                            : "الغاء"),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Provider.of<ProductsProvider>(
                                                              context,
                                                              listen: false)
                                                          .deleteProduct(
                                                              snapshot.data.id)
                                                          .then((value) {
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  HomeScreen()),
                                                          ModalRoute.withName(
                                                              '/'),
                                                        );
                                                      });
                                                    },
                                                    child: Text(
                                                        prefProvider.language ==
                                                                Languages.en
                                                            ? "Yes"
                                                            : "نعم"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Text(
                                            prefProvider.language ==
                                                    Languages.en
                                                ? "Delete"
                                                : "حذف",
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
                                            child: Text(
                                              prefProvider.language ==
                                                      Languages.en
                                                  ? "Mark as Sold"
                                                  : "تم البيع",
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
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RedoneConversationScreen(
                                            receivingUser: snapshot.data.user,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      prefProvider.language == Languages.en
                                          ? "Contact Owner"
                                          : "التواصل مع المالك",
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
