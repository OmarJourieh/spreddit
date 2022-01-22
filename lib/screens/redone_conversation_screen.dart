import 'dart:async';

import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RedoneConversationScreen extends StatefulWidget {
  RedoneConversationScreen({Key key, this.receivingUser}) : super(key: key);
  final User receivingUser;

  @override
  State<RedoneConversationScreen> createState() =>
      _RedoneConversationScreenState();
}

class _RedoneConversationScreenState extends State<RedoneConversationScreen> {
  var _controller = ScrollController();
  var _textController = TextEditingController(text: '');

  String content = "";
  @override
  Widget build(BuildContext context) {
    _controller = ScrollController();
    Timer(
      Duration(milliseconds: 1100),
      () => _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
    content = "";
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double appbarHeight = AppBar().preferredSize.height;
    final double safePadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      // backgroundColor: Colors.blue.withAlpha(40),
      appBar: getAppBar(title: widget.receivingUser.username),
      body: SingleChildScrollView(
        child: Container(
          height: height - appbarHeight - safePadding,
          child: Stack(
            // mainAxisSize: MainAxisSize.min,
            children: [
              // Positioned(bottom: 10, left: 10, child: Text('My child')),
              Container(
                height: height - appbarHeight - safePadding,
                child: FutureBuilder(
                  future: Provider.of<MessagesProvider>(context, listen: false)
                      .getConversationWithUser(
                          user.id, widget.receivingUser.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        return Container(
                          color: Colors.blue.withAlpha(40),
                          height: height * 0.82,
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: height * 0.1,
                          ),
                          child: ListView.builder(
                            controller: _controller,
                            shrinkWrap: true,
                            // reverse: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  snapshot.data[index].type == "sent"
                                      ? getSentMessage(
                                          snapshot.data[index].content)
                                      : getReceivedMessage(
                                          snapshot.data[index].content),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: height * 0.1,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextField(
                          controller: _textController,
                          onChanged: (value) {
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
                          setState(
                            () {
                              Provider.of<MessagesProvider>(context,
                                      listen: false)
                                  .sendMessage(
                                senderId: user.id,
                                receiverId: widget.receivingUser.id,
                                content: content,
                              );
                              content = "";
                              _textController.text = "";
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          );
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                  color: Colors.green.withAlpha(40),
                ),
              ),
            ],
          ),
        ),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: const BoxDecoration(
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
                style: const TextStyle(
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                // border: Border.all(
                //     // color: primaryColor,
                //     ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Text(
                content,
                style: const TextStyle(
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
