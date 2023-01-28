import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/add_new_class.dart';
import 'package:qr_attendence_system/screens/Adminscreens/class_page.dart';

class admin_Homepage extends StatefulWidget {
  const admin_Homepage({Key? key}) : super(key: key);

  @override
  State<admin_Homepage> createState() => _admin_HomepageState();
}

class _admin_HomepageState extends State<admin_Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.logout_rounded,
              color: maincolor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            //tile
            classTile(),
            classTile(),
            classTile(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => add_newclass()));
        },
        label: Text("Add New Class"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }
}

class classTile extends StatelessWidget {
  const classTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
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
                    // color: maincolor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset("assets/qrcode.jpg"),
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
                        Text(
                          "Description of the class in long word ad"
                          "slfk asdfasdflj;lckj poij io",
                        ),
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
