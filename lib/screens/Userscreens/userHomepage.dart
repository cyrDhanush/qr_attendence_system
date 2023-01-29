import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';

class userHomepage extends StatefulWidget {
  const userHomepage({Key? key}) : super(key: key);

  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("User Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.logout_rounded,
              color: maincolor,
            ),
          ),
        ],
      ),
    );
  }
}
