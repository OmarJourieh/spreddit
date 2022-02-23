import 'dart:io';
import 'dart:ui';

import 'package:first_app/constants/data.dart';
import 'package:first_app/models/category.dart';
import 'package:first_app/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/screens/TOS_screen.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/register_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "omar@gmail.com";
  String password = "omaromar";
  bool tryingToLogin = false;
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color4,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: height * 0.25),
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Container(
                        child: Text(
                          "SPREDDIT",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: height * 0.05,
                            fontFeatures: [FontFeature.enable('smcp')],
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.15), //space under title
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          this.email = value;
                        });
                      },
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        hintText: prefProvider.language == Languages.en
                            ? "Email"
                            : "البريد الالكتروني",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.15, vertical: 0),
                    child: TextField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      onChanged: (value) {
                        setState(() {
                          this.password = value;
                        });
                      },
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                        hintText: prefProvider.language == Languages.en
                            ? "Password"
                            : 'كلمة المرور',
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.05),
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                tryingToLogin = true;
                              });
                              try {
                                Auth auth = Auth(
                                  email: email,
                                  password: password,
                                );
                                await Provider.of<AuthsProvider>(context,
                                        listen: false)
                                    .login(auth);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => HomeScreen()),
                                );
                              } on HttpException catch (error) {
                                if (error.toString().contains("EMAIL_EXISTS")) {
                                } else if (error
                                    .toString()
                                    .contains("invalid email")) {
                                  setState(() {
                                    tryingToLogin = false;
                                  });
                                }
                              } catch (error) {
                                setState(() {
                                  tryingToLogin = false;
                                });
                              }
                            },
                            child: tryingToLogin == false
                                ? Text(
                                    prefProvider.language == Languages.en
                                        ? "login"
                                        : 'تسجيل الدخول',
                                    style: TextStyle(
                                      fontFeatures: [
                                        FontFeature.enable('smcp')
                                      ],
                                      color: whiteColor,
                                    ),
                                  )
                                : CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(primaryColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.15),
                    ],
                  ),
                  SizedBox(height: height * 0.005),
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            prefProvider.language == Languages.en
                                ? "register"
                                : 'التسجيل',
                            style: TextStyle(
                              fontFeatures: [FontFeature.enable('smcp')],
                              color: whiteColor,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(secondaryColor),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.15),
                    ],
                  ),
                ],
              ), //space above title

              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'English',
                    style: TextStyle(
                      color: greyColor,
                    ),
                  ),
                  Switch(
                    value: isArabic,
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        isArabic = value;
                        if (isArabic == false) {
                          prefProvider.language = Languages.en;
                          allCategories = [
                            Category(id: 1, name: "Furniture", image: ""),
                            Category(id: 2, name: "Electronics", image: ""),
                            Category(id: 3, name: "Appliances", image: ""),
                            Category(id: 4, name: "Sports", image: ""),
                            Category(id: 5, name: "Clothing", image: ""),
                            Category(id: 6, name: "Vehicles", image: ""),
                          ];
                        } else {
                          prefProvider.language = Languages.ar;
                          allCategories = [
                            Category(id: 1, name: "أثاث", image: ""),
                            Category(id: 2, name: "الكترونيات", image: ""),
                            Category(id: 3, name: "أدوات كهربائية", image: ""),
                            Category(id: 4, name: "رياضة", image: ""),
                            Category(id: 5, name: "ملابس", image: ""),
                            Category(id: 6, name: "مركبات", image: ""),
                          ];
                        }
                      });
                    },
                  ),
                  Text(
                    'Arabic',
                    style: TextStyle(
                      color: greyColor,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  SizedBox(width: width * 0.15),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => TOSScreen()));
                      },
                      child: Text(
                        prefProvider.language == Languages.en
                            ? "terms of service"
                            : "شروط الاستخدام",
                        style: TextStyle(
                          color: greyColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      style: ButtonStyle(),
                    ),
                  ),
                  SizedBox(width: width * 0.15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
