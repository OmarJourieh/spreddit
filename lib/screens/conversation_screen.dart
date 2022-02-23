import 'dart:async';

import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen2 extends StatefulWidget {
  final User receivingUser;

  ConversationScreen2({Key key, this.receivingUser}) : super(key: key);

  @override
  State<ConversationScreen2> createState() => _ConversationScreen2State();
}

class _ConversationScreen2State extends State<ConversationScreen2> {
  // var _controller = ScrollController();
  final _formKey = GlobalKey<FormState>();

  String content = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ConversationScreen2 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(title: widget.receivingUser.username),
      body: FutureBuilder(
        future: Provider.of<MessagesProvider>(context, listen: false)
            .getConversationWithUser(user.id, widget.receivingUser.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              print(snapshot.data);
              return Column(
                children: [
                  Container(
                    color: Colors.blue.withAlpha(40),
                    height: height * 0.82,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: ListView.builder(
                      // controller: _controller,
                      shrinkWrap: true,
                      // reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            snapshot.data[index].type == "sent"
                                ? getSentMessage(snapshot.data[index].content)
                                : getReceivedMessage(
                                    snapshot.data[index].content),
                          ],
                        );
                      },
                    ),
                  ),
                  // Container(child: Text("Hello")),
                  Container(
                    // height: height * 0.1,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: TextField(
                            key: _formKey,
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
                            setState(() {
                              if (content != "") {
                                Provider.of<MessagesProvider>(context,
                                        listen: false)
                                    .sendMessage(
                                  senderId: user.id,
                                  receiverId: widget.receivingUser.id,
                                  content: content,
                                );
                              }
                              // _controller.dispose();
                            });
                          },
                          icon: Icon(Icons.send),
                        ),
                      ],
                    ),
                    color: Colors.green.withAlpha(40),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }

  getSentMessage(String content) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.blue,
                // border: Border.all(
                //     // color: primaryColor,
                //     ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  getReceivedMessage(String content) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // border: Border.all(
                //     // color: primaryColor,
                //     ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 20,
                  // color: Colors.white,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
