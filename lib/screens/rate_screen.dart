import 'package:first_app/constants/colors.dart';
import 'package:first_app/models/user.dart';
import 'package:first_app/providers/auths_provider.dart';
import 'package:first_app/screens/my_profile_screen.dart';
import 'package:first_app/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';

class RateScreen extends StatefulWidget {
  final User user;
  const RateScreen({Key key, @required this.user}) : super(key: key);

  @override
  State<RateScreen> createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  int _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    User currentUser = Provider.of<AuthsProvider>(context, listen: false).user1;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Provider.of<AuthsProvider>(context, listen: false)
              .rateUser(currentUser.id, widget.user.id, _currentValue);
          Navigator.pop(context);
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => MyProfileScreen(user: widget.user)));
        },
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Colors.grey,
      ),
      backgroundColor: color3,
      appBar: getAppBar(title: "Rate ${widget.user.username}"),
      body: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("$_currentValue / 5 ",
                    style: const TextStyle(fontSize: 50)),
              ],
            ),
            const SizedBox(height: 100),
            NumberPicker(
              selectedTextStyle: TextStyle(color: color4, fontSize: 40),
              value: _currentValue,
              minValue: 0,
              maxValue: 5,
              axis: Axis.horizontal,
              onChanged: (value) => setState(() => _currentValue = value),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
