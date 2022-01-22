import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:first_app/widgets/my_drawer.dart';

class RatesScreen extends StatelessWidget {
  const RatesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(title: "Rates"),
      bottomNavigationBar: BottomNavBar(),
      drawer: getDrawer(height: height, width: width, context: context),
      body: Column(
        children: [],
      ),
    );
  }
}
