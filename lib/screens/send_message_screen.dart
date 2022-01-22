import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/screens/messages_screen.dart';
import 'package:first_app/screens/redone_conv_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendMessageScreen extends StatelessWidget {
  final User receivingUser;
  const SendMessageScreen({Key key, @required this.receivingUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    String content = "";
    return Scaffold(
      backgroundColor: color3,
      body: SingleChildScrollView(
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
              ),
              Expanded(
                child: Container(
                  // height: height * 0.2,
                  margin: EdgeInsets.symmetric(vertical: 120),
                  color: Colors.green.withAlpha(40),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextField(
                          autofocus: true,
                          onChanged: (value) {
                            // setState(() {
                            //   this.name = value;
                            // });
                            content = value;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 15, bottom: 11, top: 11, right: 15),
                            hintText: "Type Message...",
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (content != "") {
                            Provider.of<MessagesProvider>(context,
                                    listen: false)
                                .sendMessage(
                              senderId: user.id,
                              receiverId: receivingUser.id,
                              content: content,
                            )
                                .then((value) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MessagesScreen(),
                                ),
                                ModalRoute.withName('/'),
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ConversationScreen(
                                    receivingUser: receivingUser,
                                  ),
                                ),
                              );
                            });
                          }
                        },
                        icon: Icon(Icons.send),
                      ),
                    ],
                  ),
                  // color: Colors.green.withAlpha(40),
                ),
              ),
              SizedBox(
                height: height * 0.3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
