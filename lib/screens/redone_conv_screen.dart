import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/screens/send_message_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationScreen extends StatelessWidget {
  final User receivingUser;

  const ConversationScreen({Key key, this.receivingUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("OK WHAT NOW BOIIIIIIIIIIIIIIYYYYYYYYYYYYYYYYYYYYY");
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: color3,
      appBar: getAppBar(title: receivingUser.username),
      body: FutureBuilder(
        future: Provider.of<MessagesProvider>(context, listen: false)
            .getConversationWithUser(user.id, receivingUser.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              print(snapshot.data);
              return SingleChildScrollView(
                physics: const FixedExtentScrollPhysics(),
                child: SizedBox(
                  height: height * 0.9,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue.withAlpha(40),
                        height: height * 0.8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: ListView.builder(
                          // controller: _controller,
                          shrinkWrap: true,
                          // reverse: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: SizedBox(
                                // height: height * 0.7,
                                child: Column(
                                  children: [
                                    snapshot.data[index].type == "sent"
                                        ? getSentMessage(
                                            snapshot.data[index].content)
                                        : getReceivedMessage(
                                            snapshot.data[index].content),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            // Navigator.of(context).push(PageRouteBuilder(
                            //     opaque: false,
                            //     pageBuilder: (BuildContext context, _, __) {
                            //       return SendMessageScreen();
                            //     }));
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return SendMessageScreen(
                                    receivingUser: receivingUser,
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.send,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
