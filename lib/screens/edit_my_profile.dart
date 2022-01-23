import 'dart:io';

import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/screens/home_screen.dart';
import 'package:first_app/screens/my_profile_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditMyProfile extends StatefulWidget {
  // Product product;
  const EditMyProfile({Key key}) : super(key: key);

  @override
  _EditMyProfileState createState() => _EditMyProfileState();
}

class _EditMyProfileState extends State<EditMyProfile> {
  final ImagePicker _picker = ImagePicker();

  String imageFile = "";
  XFile displayImage;
  bool gotTheImage = false;

  String username = "";
  String address = "";
  String phone = "";
  String email = "";
  String oldPassword = "";
  String newPassword = "";

  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<AuthsProvider>(context).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final double appbarHeight = AppBar().preferredSize.height;
    final double safePadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(title: "Edit Profile"),
      body: SingleChildScrollView(
        child: Container(
          height: height - appbarHeight - safePadding,
          child: FutureBuilder(
            future: Provider.of<AuthsProvider>(context).getUserById(user.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        print("Opening Gallery!!!");
                        XFile image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        displayImage = image;
                        imageFile = image.path;
                        setState(() {
                          gotTheImage = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          color: Colors.white,
                          // borderRadius: const BorderRadius.all(
                          //   Radius.circular(2000.0),
                          // ),
                        ),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        height: height * 0.3,
                        width: height * 0.3,
                        child: gotTheImage == false
                            ? Icon(
                                Icons.add,
                                color: primaryColor,
                                size: 50.0,
                              )
                            : Image.file(
                                File(displayImage.path),
                              ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        initialValue: snapshot.data.username,
                        onChanged: (value) {
                          setState(() {
                            username = value;
                            print("New username: $username");
                          });
                        },
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Username",
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        initialValue: snapshot.data.address,
                        onChanged: (value) {
                          setState(() {
                            address = value;
                            print("New address: $address");
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Address",
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        initialValue: snapshot.data.phone,
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                            print("New phone: $phone");
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Phone Number",
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        initialValue: snapshot.data.email,
                        onChanged: (value) {
                          setState(() {
                            email = value;
                            print("New email: $email");
                          });
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    Container(
                      width: width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextButton(
                        style: ButtonStyle(
                          // padding: EdgeInsets.zero,
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                        ),
                        child: const Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Auth userToSend = Auth(
                            id: snapshot.data.id,
                            email: email != "" ? email : snapshot.data.email,
                            username: username != ""
                                ? username
                                : snapshot.data.username,
                            address:
                                address != "" ? address : snapshot.data.address,
                            phone: phone != "" ? phone : snapshot.data.phone,
                            imageToSend: imageFile != "" ? imageFile : "null",
                          );
                          await Provider.of<AuthsProvider>(context,
                                  listen: false)
                              .updateUser(userToSend);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    HomeScreen()),
                            ModalRoute.withName('/'),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  MyProfileScreen(
                                user: snapshot.data,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
