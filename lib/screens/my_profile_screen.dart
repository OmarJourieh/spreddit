import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/screens/edit_my_profile.dart';
import 'package:first_app/screens/redone_conversation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/api.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/product.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/product_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MyProfileScreen extends StatefulWidget {
  MyProfileScreen({Key key, @required this.user}) : super(key: key);

  User user;

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  // get color3 => null;
  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth currentUser = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    bool isMyProfile = (currentUser.id == widget.user.id);
    print(isMyProfile);
    // ignore: dead_code
    return Scaffold(
      extendBody: true,
      backgroundColor: color3,
      appBar: getAppBar(
        title: isMyProfile
            ? (prefProvider.language == Languages.en ? "My Profile" : "حسابي")
            : (prefProvider.language == Languages.en
                ? "${widget.user.username}'s Profile"
                : "${widget.user.username} حساب"),
      ),
      body: FutureBuilder(
        //1
        future: Future.wait([
          Provider.of<ProductsProvider>(context, listen: false)
              .getAllProductsOfUser(widget.user.id),
          Provider.of<AuthsProvider>(context, listen: false)
              .getUserById(widget.user.id),
          Provider.of<AuthsProvider>(context, listen: false)
              .getUserRate(widget.user.id),
        ]),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              List<Product> filteredList =
                  snapshot.data[0].where((i) => i.isSold != 1).toList();
              return SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: height,
                    child: Column(
                      children: [
                        TabBar(
                          controller: _tabController,
                          labelColor: Colors.black87,
                          unselectedLabelColor: whiteColor,
                          indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: Colors.black26)),
                          tabs: [
                            Tab(
                              text: prefProvider.language == Languages.en
                                  ? 'User\'s Information'
                                  : "معلومات المستخدم",
                            ),
                            Tab(
                              text: prefProvider.language == Languages.en
                                  ? 'User\'s Products'
                                  : "منتجات المستخدم",
                            )
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                // height: 200,
                                // width: 200,
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      // part 1
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: height * 0.3,
                                            width: height * 0.3,
                                            child: CircleAvatar(
                                              radius: 70.0,
                                              backgroundImage: snapshot
                                                          .data[1].image ==
                                                      null
                                                  ? const AssetImage(
                                                      'assets/images/person.png')
                                                  : NetworkImage(imagesRoot +
                                                      snapshot.data[1].image),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12.0,
                                          ),
                                          Card(
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.supervised_user_circle,
                                                color: Colors.cyan[700],
                                              ),
                                              title: Text(
                                                snapshot.data[1].username,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.location_city,
                                                color: Colors.cyan[700],
                                              ),
                                              title: Text(
                                                snapshot.data[1].address,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.phone,
                                                color: Colors.cyan[700],
                                              ),
                                              title: Text(
                                                snapshot.data[1].phone,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.email,
                                                color: Colors.cyan[700],
                                              ),
                                              title: Text(
                                                snapshot.data[1].email,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                          Card(
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.star,
                                                color: Colors.cyan[700],
                                              ),
                                              title: Text(
                                                snapshot.data[2] + " / 5",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0,
                                                    color: Colors.black87),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      isMyProfile
                                          ? Row(
                                              children: [
                                                Expanded(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              EditMyProfile(),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      prefProvider.language ==
                                                              Languages.en
                                                          ? "Edit Profile"
                                                          : "تعديل الحساب",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                                  primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  RedoneConversationScreen(
                                                                      receivingUser:
                                                                          widget
                                                                              .user),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          prefProvider.language ==
                                                                  Languages.en
                                                              ? "Contact ${widget.user.username}"
                                                              : "${widget.user.username} تواصل مع",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      primaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (_) =>
                                                                  RedoneConversationScreen(
                                                                      receivingUser:
                                                                          widget
                                                                              .user),
                                                            ),
                                                          );
                                                        },
                                                        child: Text(
                                                          prefProvider.language ==
                                                                  Languages.en
                                                              ? "Contact ${widget.user.username}"
                                                              : "${widget.user.username} تواصل مع",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(
                                                                      primaryColor),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                                  // image: NetworkImage(snapshot.data[index].image),
                                                  image: filteredList[index]
                                                              .image !=
                                                          null
                                                      ? NetworkImage(
                                                          imagesRoot +
                                                              filteredList[
                                                                      index]
                                                                  .image)
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      filteredList[index]
                                                                  .name
                                                                  .length <=
                                                              17
                                                          ? filteredList[index]
                                                              .name
                                                          : filteredList[index]
                                                                  .name
                                                                  .substring(
                                                                      0, 17) +
                                                              "...",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    // Text(filteredList[index]
                                                    //         .price
                                                    //         .toString() +
                                                    //     " s.p."),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: primaryColor
                                                      .withOpacity(0.2),
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Text(filteredList[index].name),
                                                    // Expanded(child: Center()),
                                                    Text(
                                                      filteredList[index]
                                                              .price
                                                              .toString() +
                                                          (prefProvider
                                                                      .language ==
                                                                  Languages.en
                                                              ? " s.p."
                                                              : "ل.س. "),
                                                      style: TextStyle(
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                  color: primaryColor
                                                      .withOpacity(0.2),
                                                  // borderRadius: BorderRadius.circular(5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
