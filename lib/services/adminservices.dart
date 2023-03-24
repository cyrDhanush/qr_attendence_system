import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/services/constants.dart';
import 'package:qr_attendence_system/services/userservices.dart';

class Adminservices {
  addnewclass(String classname, String classdescription) async {
    try {
      DocumentReference classid = await classref.add({
        'classname': classname,
        'classdescription': classdescription,
        'joinedusers': {},
      });
      return classid;
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future getallclasses() async {
    QuerySnapshot snapshot = await classref.get();
    List s = snapshot.docs.map((e) => iddata(e.id, e.data())).toList();

    List<Classmodel> classmodellist = [];
    for (iddata i in s) {
      classmodellist.add(
        Classmodel(
          classkey: i.id,
          classname: i.data['classname'],
          classdescription: i.data['classdescription'],
          joinedusers: i.data['joinedusers'],
        ),
      );
    }
    return classmodellist;
  }

  deleteclass({required String classid}) async {
    DocumentSnapshot snapshot = await classref.doc(classid).get();
    Userservices userservices = Userservices();
    Map joinedusers = snapshot.get('joinedusers');
    for (String userids in joinedusers.keys) {
      userservices.removefromclass(classid: classid, userid: userids);
    }

    await classref.doc(classid).delete();
    print('deleted');
  }
}
