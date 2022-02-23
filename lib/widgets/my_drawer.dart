import 'dart:ui';

import 'package:first_app/models/user.dart';
import 'package:first_app/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/screens/history_screen.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:first_app/screens/my_products_screen.dart';
import 'package:first_app/screens/my_profile_screen.dart';
import 'package:provider/provider.dart';

class getDrawer extends StatelessWidget {
  double height;
  double width;
  getDrawer(
      {Key key, @required this.height, @required this.width, @required context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    User user1 = Provider.of<AuthsProvider>(context, listen: false).user1;
    return Drawer(
      child: Container(
        height: height,
        color: color3,
        child: ListView(
          children: [
            SizedBox(height: height * 0.12),
            Row(
              children: [
                SizedBox(width: width * 0.04),
                Container(
                  child: Text(
                    "Spreddit",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: height * 0.04,
                      fontFeatures: [FontFeature.enable('smcp')],
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.04),
            drawerItem(
              callback: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => MyProfileScreen(user: user1)));
              },
              height: height,
              icon: Icons.person,
              text:
                  prefProvider.language == Languages.en ? "profile" : "الحساب",
            ),
            drawerItem(
              callback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => MyProductsScreen()),
                );
              },
              height: height,
              icon: Icons.lock_clock,
              text: prefProvider.language == Languages.en
                  ? "my products"
                  : "منتجاتي",
            ),
            drawerItem(
              callback: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => HistoryScreen()),
                );
              },
              height: height,
              icon: Icons.history,
              text: prefProvider.language == Languages.en ? "history" : "السجل",
            ),
            drawerItem(
              callback: () async {
                await Provider.of<AuthsProvider>(context, listen: false)
                    .logout();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => LoginScreen()));
              },
              height: height,
              icon: Icons.logout,
              text: prefProvider.language == Languages.en
                  ? "Log out"
                  : "تسجيل الخروج",
            ),
          ],
        ),
      ),
    );
  }
}

getDrawer2({@required height, @required width, @required context}) {
  return Drawer(
    child: Container(
      height: height,
      color: color3,
      child: ListView(
        children: [
          SizedBox(height: height * 0.12),
          Row(
            children: [
              SizedBox(width: width * 0.04),
              Container(
                child: Text(
                  "Spreddit",
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: height * 0.04,
                    fontFeatures: [FontFeature.enable('smcp')],
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.04),
          drawerItem(
            callback: () {},
            height: height,
            icon: Icons.person,
            text: "profile",
          ),
          drawerItem(
            callback: () {},
            height: height,
            icon: Icons.lock_clock,
            text: "my products",
          ),
          drawerItem(
            callback: () {},
            height: height,
            icon: Icons.history,
            text: "history",
          ),
          drawerItem(
            callback: () {
              Provider.of<AuthsProvider>(context, listen: false).logout();
            },
            height: height,
            icon: Icons.logout,
            text: "Log out",
          ),
        ],
      ),
    ),
  );
}

drawerItem({height, text, icon, Function callback}) {
  return ListTile(
    onTap: callback,
    leading: Icon(
      icon,
      color: Colors.white,
    ),
    title: Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: height * 0.025,
        fontFeatures: [FontFeature.enable('smcp')],
        letterSpacing: 2,
      ),
    ),
  );
}
