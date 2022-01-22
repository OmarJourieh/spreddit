import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/favorites_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/providers/products_provider.dart';
import 'package:first_app/screens/login_screen.dart';
import './providers/auths_provider.dart';
import './providers/categories_provider.dart';
import 'package:provider/provider.dart';

import 'screens/api_screen.dart';

void main() {
  runApp(
    // DevicePreview(
    //   enabled: true,
    //   tools: [
    //     ...DevicePreview.defaultTools,
    //     // const CustomPlugin(),
    //   ],
    //   builder: (context) =>
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthsProvider()),
        ChangeNotifierProvider(create: (context) => ProductsProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => MessagesProvider()),
      ],
      child: Consumer<AuthsProvider>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          // useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(ctx),
          // builder: DevicePreview.appBuilder,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          home: Builder(
            builder: (context) => APIScreen(),
          ),
        ),
      ),
    ),
    // ),
  );
}
