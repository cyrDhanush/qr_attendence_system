import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/bin/qr_scanning_screen.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/screens/loadingScreen.dart';
import 'package:qr_attendence_system/screens/loadingblock.dart';
import 'package:qr_attendence_system/screens/signing/loginwithemail.dart';
import 'package:qr_attendence_system/services/constants.dart';
import 'package:qr_attendence_system/services/localauthentication.dart';
import 'package:qr_attendence_system/services/userservices.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:local_auth/local_auth.dart';

class userHomepage extends StatefulWidget {
  final String userkey;
  const userHomepage({Key? key, required this.userkey}) : super(key: key);

  @override
  State<userHomepage> createState() => _userHomepageState();
}

class _userHomepageState extends State<userHomepage> {
  Userservices userservices = Userservices();
  localAuthentication authentication = localAuthentication();
  List<Classmodel?> classDetails = [];
  late Usermodel snapshot;
  bool preloading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    update();
  }

  update() async {
    snapshot = await userservices.getuserDetails(widget.userkey);

    classDetails = await userservices.getjoinedclasses(snapshot.joinedclasses);
    print('hepped');
    setState(() {});
    preloading = false;
  }

  class_confirmation(
      {required String classname,
      required String classdescription,
      required String classid,
      required String userid}) async {
    await showModalBottomSheet(
      context: context,
      barrierColor: Colors.black.withAlpha(150),
      elevation: 7,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (context) => Container(
        height: 300,
        padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
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
            const Text(
              "Do You Want to Join this Class ?",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              // "Class Name",
              classname,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              // 'class description',
              classdescription,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
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
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () async {
                    bool isAuthenticated = await authentication.authenticate(
                        reason: 'Please Authenticate to Join a Class');
                    // bool isAuthenticated = true;
                    if (isAuthenticated == true) {
                      loadingBlock(context: context);
                      await userservices.joinclass(
                        classid: classid,
                        userid: userid,
                      );

                      print('joined in a class');
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else {
                      print('Not Joined');
                    }

                    print('clicked');
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
                    child: const Text(
                      "Join",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  incorrect_code() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(20),
              height: 300,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(
                  //   height: 20,
                  // ),
                  const Expanded(
                    child: Icon(
                      CupertinoIcons.nosign,
                      color: Colors.red,
                      size: 80,
                    ),
                  ),
                  const Text(
                    "Sorry, Incorrect class QR code !!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return (preloading == true)
        ? (const loadingScreen())
        : (Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text("Hello, " + snapshot.username),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            body: Container(
              child: (classDetails.length != 0)
                  ? (ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100, top: 10),
                      itemCount: classDetails.length,
                      itemBuilder: (context, i) {
                        return classCard(
                          classid: classDetails[i]!.classkey,
                          userid: widget.userkey,
                          classname: classDetails[i]!.classname,
                          classdescription: classDetails[i]!.classdescription,
                          update: update,
                        );
                      },
                    ))
                  : (Center(
                      child: Text(
                        "Scan QR code to Join a Class",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black.withAlpha(150),
                        ),
                      ),
                    )),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                var scannedcode = await FlutterBarcodeScanner.scanBarcode(
                    '#783F8E', "Cancel", false, ScanMode.QR);
                // var scannedcode = democlassid;
                if (scannedcode != null && scannedcode != -1) {
                  DocumentSnapshot classdetails =
                      await userservices.getclassdetail(scannedcode);
                  if (classdetails.data() != null) {
                    //class found
                    await class_confirmation(
                      classname: classdetails.get('classname'),
                      classdescription: classdetails.get('classdescription'),
                      classid: scannedcode,
                      userid: snapshot.userkey.toString(),
                    );
                    update();
                  } else {
                    // incorrect code
                    incorrect_code();
                  }
                }
              },
              icon: const Icon(Icons.qr_code_scanner_rounded),
              label: const Text("Scan QR Code"),
            ),
          ));
  }
}

class classCard extends StatefulWidget {
  final String classid;
  final String userid;
  final String classname;
  final String classdescription;
  final Function update;
  const classCard({
    Key? key,
    required this.classid,
    required this.classdescription,
    required this.userid,
    this.classname = '',
    required this.update,
  }) : super(key: key);

  @override
  State<classCard> createState() => _classCardState();
}

class _classCardState extends State<classCard> {
  final Userservices userservices = Userservices();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          elevation: 7,
          foregroundColor: maincolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Container(
          // height: 100,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      // "Class Name",
                      widget.classname,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.classdescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () async {
                  loadingBlock(context: context); // opening loading dialog
                  await userservices.removefromclass(
                      classid: widget.classid, userid: widget.userid);
                  widget.update();
                  Navigator.pop(context); // popping loading dialog

                  print('removed');
                },
                icon: const Icon(
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
