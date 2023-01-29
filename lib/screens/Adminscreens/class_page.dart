import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/screens/Adminscreens/studentlist.dart';
import 'package:qr_flutter/qr_flutter.dart';

class classPage extends StatefulWidget {
  final classmodel classobj;
  const classPage({Key? key, required this.classobj}) : super(key: key);

  @override
  State<classPage> createState() => _classPageState();
}

class _classPageState extends State<classPage> {
  DatabaseReference ref = FirebaseDatabase.instance.ref('classdetails/');
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
        title: Text(
          // "Class Name",
          widget.classobj.classname,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.child(widget.classobj.classid).remove();
              print("deleted");
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: MediaQuery.of(context).size.width - 30,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: QrImage(
                  data: widget.classobj.classid,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.all(10),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              widget.classobj.classdescription,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => studentList(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 7,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Student List",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_rounded,
                    size: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
