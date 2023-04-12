import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
    );
  }
}

class firestoresample extends StatefulWidget {
  const firestoresample({Key? key}) : super(key: key);

  @override
  State<firestoresample> createState() => _firestoresampleState();
}

class _firestoresampleState extends State<firestoresample> {
  FirebaseFirestore instance = FirebaseFirestore.instance;
  late CollectionReference userref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userref = instance.collection('users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ElevatedButton(
        onPressed: () async {
          await userref.doc('thisistheid').set({
            'name': 'Dhanush',
            'age': 29,
          }).then((value) => print('Success'), onError: (e) {
            print(e.toString());
          });
        },
        child: const Text('data'),
      ),
    );
  }
}
