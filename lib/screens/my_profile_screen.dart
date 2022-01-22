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
          title:
              isMyProfile ? "My Profile" : "${widget.user.username}'s Profile"),
      body: FutureBuilder(
        //1
        future: Future.wait([
          Provider.of<ProductsProvider>(context, listen: false)
              .getAllProductsOfUser(widget.user.id),
          Provider.of<AuthsProvider>(context, listen: false)
              .getUserById(widget.user.id),
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
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      labelColor: Colors.black87,
                      unselectedLabelColor: whiteColor,
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(color: Colors.black26)),
                      tabs: const [
                        // Text(
                        //   "User's Information",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "User's Products",
                        //   style: TextStyle(fontWeight: FontWeight.bold),
                        // ),
                        Tab(
                          text: 'User\'s Information',
                        ),
                        Tab(
                          text: 'User\'s Products',
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
                            child: Expanded(
                              child: Column(
                                children: [
                                  // part 1
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const CircleAvatar(
                                        radius: 70.0,
                                        backgroundImage: AssetImage(
                                            'assets/images/person.png'),
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
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  isMyProfile
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {},
                                                child: Text(
                                                  "Edit Profile",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          RedoneConversationScreen(
                                                              receivingUser:
                                                                  widget.user),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Contact ${widget.user.username}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          primaryColor),
                                                ),
                                              ),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  filteredList[index]
                                                              .name
                                                              .length <=
                                                          17
                                                      ? filteredList[index].name
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
                                              color:
                                                  primaryColor.withOpacity(0.2),
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
                                                      " s.p.",
                                                  style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic),
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  primaryColor.withOpacity(0.2),
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
              );
            }
          }
        },
      ),
    );
  }
}
