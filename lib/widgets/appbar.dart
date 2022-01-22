import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';

getAppBar({title: "Spreddit", hasSearch = false, Function callback}) {
  return AppBar(
    backgroundColor: secondaryColor,
    elevation: 0,
    actions: hasSearch == true
        ? [IconButton(onPressed: callback, icon: Icon(Icons.search))]
        : [],
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        // fontSize: height * 0.06,
        fontFeatures: [FontFeature.enable('smcp')],
        letterSpacing: 2,
      ),
    ),
  );
}

// class MyAppBar extends StatelessWidget {
//   const MyAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: color3,
//       elevation: 0,
//       // centerTitle: true,
//       title: Text(
//         "Spreddit",
//         style: TextStyle(
//           color: Colors.white,
//           // fontSize: height * 0.06,
//           fontFeatures: [FontFeature.enable('smcp')],
//           letterSpacing: 2,
//         ),
//       ),
//     );
//   }
// }
