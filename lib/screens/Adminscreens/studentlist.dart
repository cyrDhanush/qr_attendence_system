import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/services/adminservices.dart';
import 'package:qr_attendence_system/services/userservices.dart';

class studentList extends StatefulWidget {
  final Classmodel classmodel;
  const studentList({Key? key, required this.classmodel}) : super(key: key);

  @override
  State<studentList> createState() => _studentListState();
}

class _studentListState extends State<studentList> {
  Adminservices adminservices = Adminservices();
  late Map joinedusers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('happened');
    joinedusers = widget.classmodel.joinedusers;
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
        title: Text("Joined Users List"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        // child: Column(
        //   children: [
        //     for (String i in joinedusers.keys)
        //       studentTile(
        //         studentkey: i,
        //       ),
        //   ],
        // ),
        child: StreamBuilder(
          stream: adminservices.getStreamofjoinedusers(
              classkey: widget.classmodel.classkey),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.data!.get('joinedusers').keys.length != 0) {
              return ListView.builder(
                  itemCount: snapshot.data!.get('joinedusers').keys.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return studentTile(
                      studentkey: snapshot.data!
                          .get('joinedusers')
                          .keys
                          .toList()[i]
                          .toString(),
                    );
                  });
            } else if (snapshot.hasData &&
                snapshot.data!.get('joinedusers').keys.length == 0) {
              return Center(
                child: Text(
                  'No Users Joined Yet!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
            // return Container(
            //   child: Text(snapshot.data!.get('joinedusers').keys.toString()),
            // );
          },
        ),
      ),
    );
  }
}

class studentTile extends StatefulWidget {
  final String studentkey;
  const studentTile({Key? key, required this.studentkey}) : super(key: key);

  @override
  State<studentTile> createState() => _studentTileState();
}

class _studentTileState extends State<studentTile> {
  Userservices userservices = Userservices();
  Future getdata() async {
    Usermodel data = await userservices.getuserDetails(widget.studentkey);

    setState(() {});
    return data;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: FutureBuilder(
            future: getdata(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            "assets/profilephoto.png",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            // "Student Name",
                            snapshot.data.username.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            // "Student ID: ",
                            snapshot.data.userkey.toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 37.5),
                  child: Container(
                    width: 50,
                    height: 5,
                    child: LinearProgressIndicator(
                      color: maincolor.withAlpha(150),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
