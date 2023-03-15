import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/bin/qr_scanning_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

// -NMyhV3D1nN39r0ZO_99 -  studentid

class userHomepage extends StatefulWidget {
  final String userkey;
  const userHomepage({Key? key, this.userkey = '-NMyhV3D1nN39r0ZO_99'})
      : super(key: key);

  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
  late DatabaseReference ref;
  late DatabaseReference classref;
  var d;

  //trial run
  String sampleclasscode = '-NN32xUXvDYgOM-22707';
  // String sampleclasscode = '-NN0aRHcLNK3k1d5V4QZ';
  // String sampleclasscode = '-NNAQLABVN18mTi97QNI';

  Future getuserdata_fromserver() async {
    var data = await ref.child(widget.userkey).get();
    return data;
  }

  Future getdata() async {
    // from variable which is already loaded from server
    if (d == null) {
      d = await getuserdata_fromserver();
    }
    return d;
  }

  Future getclassdetails(key) async {
    // getting class details
    DatabaseReference reference =
        FirebaseDatabase.instance.ref('classdetails/$key');

    var data = await reference.get();
    return data;
  }

  Future isalreadyinclass(key) async {
    var data = await ref.child(widget.userkey + '/joinedclasses').get();
    for (var i in data.children) {
      if (i.child('classcode').value == key) {
        return true;
      }
    }
    return false;
  }

  Future getjoinedclasslist() async {
    List keylist = [];
    var data = await ref.child(widget.userkey + '/joinedclasses').get();
    for (var i in data.children) {
      keylist.add(i.child('classcode').value);
    }
    setState(() {});
    return keylist;
  }

  void unenroll() async {
    // remove user from class
    // remove class from user
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.ref('userdetails/');
    classref = FirebaseDatabase.instance.ref('classdetails/');
    getuserdata_fromserver();
  }

  class_confirmation({required String classkey}) {
    showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withAlpha(150),
      elevation: 7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) => FutureBuilder(
        future: getclassdetails(classkey),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.value != null) {
            return Container(
              height: 300,
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 7,
                    width: 40,
                    decoration: BoxDecoration(
                      color: maincolor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Text(
                    "Do You Want to Join this Class ?",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    // "Class Name",
                    snapshot.data.child('classname').value.toString(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    snapshot.data.child('classdescription').value.toString(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red.withAlpha(30),
                          foregroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Container(
                          height: 30,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          var ispresent = await isalreadyinclass(classkey);
                          if (!ispresent) {
                            await ref
                                .child(widget.userkey.toString() +
                                    '/joinedclasses/')
                                .push()
                                .set({
                              'classcode': classkey.toString(),
                            });
                            await classref
                                .child(classkey.toString() + '/joinedusers')
                                .push()
                                .set({
                              'usercode': widget.userkey.toString(),
                            });
                            // snack bar to show joined
                          } else {
                            // snack bar to show already present
                          }
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: maincolor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Container(
                          height: 30,
                          width: 80,
                          alignment: Alignment.center,
                          child: Text(
                            "Join",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data.value == null) {
            return Container(
              padding: EdgeInsets.all(20),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sorry, Incorrect class QR code",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red.withAlpha(30),
                      foregroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Container(
                      height: 30,
                      alignment: Alignment.center,
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              height: 300,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Text("Hello, " + data!.child('username').value.toString() ?? ''),
        title: FutureBuilder(
          future: getdata(),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                  "Hello, " + snapshot.data.child('username').value.toString());
            } else {
              return Text("Hello ");
            }
          }),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: FutureBuilder(
            future: getjoinedclasslist(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return classcard(classkey: snapshot.data[i]);
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          class_confirmation(
            classkey: sampleclasscode,
          );
        },
        icon: Icon(Icons.qr_code_scanner_rounded),
        label: Text("Scan QR Code"),
      ),
    );
  }

  Widget classcard({required String classkey}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          // height: 100,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              FutureBuilder(
                future: getclassdetails(classkey),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            // "Class Name",
                            snapshot.data.child('classname').value,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            // 'Descripton is not provided',
                            snapshot.data.child('classdescription').value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.logout_rounded,
                  color: Colors.red,
                  semanticLabel: "Log Out of Class",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
