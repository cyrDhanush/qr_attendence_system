import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Userscreens/qr_scanning_screen.dart';
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
  var d;
  Future getuserdata_fromserver() async {
    var data = await ref.child(widget.userkey).get();
    return data;
  }

  Future getdata() async {
    if (d == null) {
      d = await getuserdata_fromserver();
    }
    return d;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.ref('userdetails/');
    getuserdata_fromserver();
  }

  void class_confirmation() {
    showModalBottomSheet(
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
              "Class Name",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "This is the description of the class and goes a long text and paragraph",
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
                  onPressed: () {},
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Class Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Descripton is not provided',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                        semanticLabel: "Log Out of Class",
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var a = await FlutterBarcodeScanner.scanBarcode(
              '#783F8E', "Cancel", false, ScanMode.QR);
          print(a.runtimeType);
          if (a != '-1') {
            print("Not Scanned");
          }
          class_confirmation();
        },
        icon: Icon(Icons.qr_code_scanner_rounded),
        label: Text("Scan QR Code"),
      ),
    );
  }
}
