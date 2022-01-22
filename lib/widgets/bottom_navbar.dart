import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/screens/categories_screen.dart';
import 'package:first_app/screens/favorites_screen.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/messages_screen.dart';
import 'package:first_app/screens/rates_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        // color: color5,
        height: height * 0.065,
        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: IconButton(
                icon: Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HomeScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: VerticalDivider(
                indent: 0,
                endIndent: 0,
                width: 0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.category, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => CategoriesScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: VerticalDivider(
                indent: 0,
                endIndent: 0,
                width: 0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.favorite, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => FavortiesScreen()),
                  );
                },
              ),
            ),
            Expanded(
              child: VerticalDivider(
                indent: 0,
                endIndent: 0,
                width: 0,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Icons.mail, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => MessagesScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // notchedShape: CircularNotchedRectangle(),
      color: primaryColor,
    );
  }
}
