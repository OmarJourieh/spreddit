import 'dart:io';
import 'dart:ui';

import 'package:first_app/providers/preferences_provider.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/screens/TOS_screen.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool tryingToRegister = false;

  String email = "";
  String password = "";
  String username = "";
  String address = "";
  String phone = "";

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
              SizedBox(height: height * 0.1), //space above title
              Column(
                children: [
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Container(
                        child: Text(
                          "SPREDDIT",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: height * 0.04,
                            fontFeatures: [FontFeature.enable('smcp')],
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Container(
                        child: Text(
                          prefProvider.language == Languages.en
                              ? "- REGISTER"
                              : "التسجيل -",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: height * 0.04,
                            fontFeatures: [FontFeature.enable('smcp')],
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.05), //space under title
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
                      onChanged: (value) {
                        setState(() {
                          this.username = value;
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
                            ? "Username"
                            : "اسم المستخدم",
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
                            : "كلمة المرور",
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
                      onChanged: (value) {
                        setState(() {
                          this.address = value;
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
                            ? "Address"
                            : "العنوان",
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
                      onChanged: (value) {
                        setState(() {
                          this.phone = value;
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
                            ? "Phone Number"
                            : "الهاتف",
                        hintStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: secondaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),
                  Row(
                    children: [
                      SizedBox(width: width * 0.15),
                      Expanded(
                        child: Container(
                          child: TextButton(
                            onPressed: () async {
                              setState(() {
                                tryingToRegister = true;
                              });
                              try {
                                Auth auth = Auth(
                                  email: email,
                                  password: password,
                                  username: username,
                                  address: address,
                                  phone: phone,
                                );
                                print("---GOING INTO PROVIDER---");
                                await Provider.of<AuthsProvider>(context,
                                        listen: false)
                                    .register(auth);
                                print("---GOING OUTTA PROVIDER---");

                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()),
                                );
                              } on HttpException catch (error) {
                                if (error.toString().contains("EMAIL_EXISTS")) {
                                  print('DIDNT GO THROUGH');
                                } else if (error
                                    .toString()
                                    .contains("invalid email")) {
                                  print('DIDNT GO THROUGH');

                                  setState(() {
                                    tryingToRegister = false;
                                  });
                                }
                              } catch (error) {
                                print('DIDNT GO THROUGH');
                                setState(() {
                                  tryingToRegister = false;
                                });
                              }
                            },
                            child: tryingToRegister == false
                                ? Text(
                                    prefProvider.language == Languages.en
                                        ? "submit"
                                        : "تسجيل",
                                    style: TextStyle(
                                      fontFeatures: const [
                                        FontFeature.enable('smcp')
                                      ],
                                      color: whiteColor,
                                    ),
                                  )
                                : const CircularProgressIndicator(
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
                            Navigator.pop(context);
                          },
                          child: Text(
                            prefProvider.language == Languages.en
                                ? "go back to login"
                                : "العودة الى تسجيل الدخول",
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
                  SizedBox(height: height * 0.005),
                ],
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Spacer(),
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
            ],
          ),
        ),
      ),
    );
  }
}
