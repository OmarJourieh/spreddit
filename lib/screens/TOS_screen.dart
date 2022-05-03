import 'package:first_app/constants/api.dart';
import 'package:flutter/material.dart';
import 'package:first_app/widgets/appbar.dart';

class TOSScreen extends StatelessWidget {
  const TOSScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          Text("This page is under construction...",
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 40),
          Text("SPREDDIT team:"),
          SizedBox(height: 20),
          Text("Dr. Haidar Al-Shammary"),
          SizedBox(height: 20),
          Text("Ehab A. Jalab"),
          SizedBox(height: 10),
          Text("Mamdouh Y. Youssef"),
          SizedBox(height: 10),
          Text("Omar S. Jourieh"),
          SizedBox(height: 10),
          Text("API: $API"),
        ],
      ),
    );
  }
}
