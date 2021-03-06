import 'package:first_app/constants/api.dart';
import 'package:first_app/providers/preferences_provider.dart';
import 'package:first_app/screens/redone_conversation_screen.dart';
import 'package:flutter/material.dart';
import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/auth.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/providers/messages_provider.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:first_app/widgets/bottom_navbar.dart';
import 'package:first_app/widgets/my_drawer.dart';
import 'package:provider/provider.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prefProvider = Provider.of<PreferencesProvider>(context);
    Auth user = Provider.of<AuthsProvider>(context, listen: false).user;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color3,
      appBar: getAppBar(
          title:
              prefProvider.language == Languages.en ? "Messages" : "الرسائل"),
      bottomNavigationBar: BottomNavBar(),
      drawer: getDrawer(height: height, width: width, context: context),
      body: FutureBuilder(
        future: Provider.of<MessagesProvider>(context, listen: false)
            .getAllConversations(user.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Error: ${snapshot.error}'));
            else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RedoneConversationScreen(
                                receivingUser: snapshot.data[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: snapshot.data[index].image == null
                                      ? AssetImage(
                                          "assets/images/profile_pic.jpg")
                                      : NetworkImage(imagesRoot +
                                          snapshot.data[index].image),
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: primaryColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(200000))),
                            child: Center(),
                          ),
                          title: Text(
                            snapshot.data[index].username,
                            style: TextStyle(
                              color: Colors.grey[800],
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(prefProvider.language == Languages.en
                              ? "Click to enter chat..."
                              : "اضغط للدخول الى المحادثة"),
                        ),
                      ),
                      Divider(
                        indent: width * 0.045,
                        endIndent: width * 0.045,
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
