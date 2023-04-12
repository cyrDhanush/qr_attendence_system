import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/screens/Adminscreens/studentlist.dart';
import 'package:qr_attendence_system/services/adminservices.dart';
import 'package:qr_flutter/qr_flutter.dart';

class classPage extends StatefulWidget {
  final Classmodel classmodel;
  const classPage({
    Key? key,
    required this.classmodel,
  }) : super(key: key);

  @override
  State<classPage> createState() => _classPageState();
}

class _classPageState extends State<classPage> {
  Adminservices adminservices = Adminservices();
  confirmdelete() async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(25),
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
            title: const Text('Delete'),
            content: const Text(
              'Do you want to Delete this Class',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () async {
                  await adminservices.deleteclass(
                    classid: widget.classmodel.classkey,
                  );
                  Navigator.pop(context); // to pop alert dialog
                  Navigator.pop(context); // to pop the screen
                },
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Delete'),
              ),
            ],
          );
        });
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
        title: Text(
          // "Class Name",
          widget.classmodel.classname,
        ),
        actions: [
          IconButton(
            onPressed: () {
              confirmdelete();
            },
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            const SizedBox(
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
                  data: widget.classmodel.classkey,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              widget.classmodel.classdescription,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => studentList(
                      classmodel: widget.classmodel,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 7,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Student List",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 30,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              widget.classmodel.classkey,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
