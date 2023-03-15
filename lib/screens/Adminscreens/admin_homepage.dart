import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/screens/Adminscreens/add_new_class.dart';
import 'package:qr_attendence_system/screens/Adminscreens/class_page.dart';
import 'package:qr_flutter/qr_flutter.dart';

class admin_Homepage extends StatefulWidget {
  const admin_Homepage({Key? key}) : super(key: key);

  @override
  State<admin_Homepage> createState() => _admin_HomepageState();
}

class _admin_HomepageState extends State<admin_Homepage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Admin Dashboard"),
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView.builder(
          itemCount: 10,
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(top: 10, bottom: 80),
          itemBuilder: (context, i) {
            return classTile();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {},
        label: Text("Add New Class"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }

  Widget classTile() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => classPage(),
            ),
          );
        },
        child: Card(
          elevation: 7,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            // height: 100,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Container(
                  // qr code
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // child: Image.asset("assets/qrcode.jpg"),
                  child: QrImage(
                    data: 'classid',
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Class Name",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('class description'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
