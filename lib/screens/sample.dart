import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class addusers extends StatefulWidget {
  const addusers({Key? key}) : super(key: key);

  @override
  State<addusers> createState() => _addusersState();
}

class _addusersState extends State<addusers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          DatabaseReference ref = FirebaseDatabase.instance.ref('userdetails');
          ref.push().set({
            'userid': '123456789',
            'userphoneno': '8903013270',
            'username': 'dhanush',
          });
        },
      ),
    );
  }
}
