import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';

class add_newclass extends StatefulWidget {
  const add_newclass({Key? key}) : super(key: key);

  @override
  State<add_newclass> createState() => _add_newclassState();
}

class _add_newclassState extends State<add_newclass> {
  TextEditingController classname = TextEditingController();
  TextEditingController classdes = TextEditingController();

  // Databaseref
  DatabaseReference ref = FirebaseDatabase.instance.ref('classdetails/');
  List data = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    classname.dispose();
    classdes.dispose();
  }

  void submit() async {
    if (classname.text.length != 0) {
      await ref.push().set(
        {
          "classname": classname.text.toString(),
          "classdescription": (classdes.text.toString() == "")
              ? ("Description not provided")
              : (classdes.text.toString()),
          "joinedstudents": [],
        },
      );
      print("Success");
      Navigator.pop(context, true);
    }
  }

  // void getdata() async {
  //   // var snapshot = await ref.get();
  //   // print(snapshot.value.runtimeType);
  //   data = [];
  //   await ref.once().then((snapshot) {
  //     print(snapshot.snapshot.children);
  //     for (var i in snapshot.snapshot.children) {
  //       data.add(i);
  //     }
  //     print(data[0].key);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: maincolor,
          ),
        ),
        title: Text("Add New Class"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              submit();
            },
            icon: Icon(
              Icons.check,
              color: maincolor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              "Class Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextField(
                controller: classname,
                decoration: textfielddecoration.copyWith(
                    hintText: "Class Name (Mandatory)"),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Class Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextField(
                controller: classdes,
                decoration: textfielddecoration.copyWith(
                    hintText: "Class Description (Optional)"),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        child: TextButton(
          onPressed: () {
            submit();
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: maincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text(
              "Submit",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
