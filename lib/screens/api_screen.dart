import 'package:first_app/constants/api.dart';
import 'package:first_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class APIScreen extends StatelessWidget {
  const APIScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              // initialValue: "192.168.43.128",
              onChanged: (value) {
                API = "http://$value:8000/api";
                imagesRoot = "http://$value/junior/storage/app";
                print(API);
                print(API);
                print(API);
                print(API);
              },
            ), //http://localhost:8000/api
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginScreen()));
                },
                child: Text("Go Go Go!"))
          ],
        ),
      ),
    );
  }
}
