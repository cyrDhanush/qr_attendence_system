import 'package:firebase_database/firebase_database.dart';
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
  DatabaseReference ref = FirebaseDatabase.instance.ref('classdetails');
  List datalist = [];
  Future getalldata() async {
    var data = await ref.get();
    datalist = [];
    for (var i in data.children) {
      datalist.add(i);
    }
    return datalist;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getalldata();
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
            future: getalldata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.only(top: 10, bottom: 80),
                    itemBuilder: (context, i) {
                      print(snapshot.data[i].value.runtimeType);
                      return classTile(
                        classobj: classmodel(
                          classid: snapshot.data[i].key,
                          classname: snapshot.data[i].value['classname'],
                          classdescription:
                              snapshot.data[i].value['classdescription'],
                          studentlist: snapshot.data[i].value['joinedstudents'],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Use",
                          style: TextStyle(
                            fontSize: 16,
                            color: maincolor,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.add,
                          color: maincolor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "to ADD New Class",
                          style: TextStyle(
                            fontSize: 16,
                            color: maincolor,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          var a = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => add_newclass()));
          if (a != null) {
            print("Data Successfully Added");
            //addsnackbar
          }
          setState(() {
            getalldata();
          });
        },
        label: Text("Add New Class"),
        icon: Icon(Icons.add_rounded),
      ),
    );
  }

  Widget classTile({required classmodel classobj}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => classPage(
                classobj: classobj,
              ),
            ),
          );
          setState(() {
            getalldata();
          });
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
                    data: classobj.classid,
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
                          // "Class Name",
                          classobj.classname.toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          classobj.classdescription.toString(),
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

// class classTile extends StatefulWidget {
//   final classmodel classobj;
//   const classTile({Key? key, required this.classobj}) : super(key: key);
//
//   @override
//   State<classTile> createState() => _classTileState();
// }
//
// class _classTileState extends State<classTile> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 5),
//       child: GestureDetector(
//         onTap: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => classPage(
//                 classobj: widget.classobj,
//               ),
//             ),
//           );
//         },
//         child: Card(
//           elevation: 7,
//           child: Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//             // height: 100,
//             width: MediaQuery.of(context).size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   // qr code
//                   height: 80,
//                   width: 80,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   // child: Image.asset("assets/qrcode.jpg"),
//                   child: QrImage(
//                     data: widget.classobj.classid,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Container(
//                     child: Column(
//                       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           // "Class Name",
//                           widget.classobj.classname.toString(),
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           widget.classobj.classdescription.toString(),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
