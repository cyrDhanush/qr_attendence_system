import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/screens/Adminscreens/add_new_class.dart';
import 'package:qr_attendence_system/screens/Adminscreens/class_page.dart';
import 'package:qr_attendence_system/services/adminservices.dart';
import 'package:qr_flutter/qr_flutter.dart';

class admin_Homepage extends StatefulWidget {
  const admin_Homepage({Key? key}) : super(key: key);

  @override
  State<admin_Homepage> createState() => _admin_HomepageState();
}

class _admin_HomepageState extends State<admin_Homepage> {
  Adminservices adminservices = Adminservices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getclassdata() async {
    setState(() {});
    return await adminservices.getallclasses();
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
        child: FutureBuilder(
          future: getclassdata(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: 10, bottom: 80),
                itemBuilder: (context, i) {
                  return classTile(
                    classmodel: snapshot.data[i],
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => add_newclass(),
            ),
          );
          setState(() {
            getclassdata();
          });
        },
        label: Text("Add New Class"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }
}

class classTile extends StatelessWidget {
  final Classmodel classmodel;
  const classTile({Key? key, required this.classmodel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => classPage(
                classmodel: classmodel,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          elevation: 7,
          foregroundColor: maincolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
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
                  data: classmodel.classkey,
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
                        classmodel.classname,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        classmodel.classdescription,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
