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

  Stream<DocumentSnapshot> getStreamofjoinedusers({required classkey}) {
    Stream<DocumentSnapshot> stream = classref.doc(classkey).snapshots();
    // var stream = classref.doc(classkey).snapshots();
    // DocumentSnapshot documentSnapshot = await classref.doc(classkey).get();
    return stream;
  }

  Future getallclasses() async {
    QuerySnapshot querySnapshot = await classref.get();
    List<Classmodel> classmodellist = [];

    for (DocumentSnapshot doc in querySnapshot.docs) {
      classmodellist.add(
        Classmodel(
          classkey: doc.id.toString(),
          classname: doc.get('classname').toString(),
          classdescription: doc.get('classdescription'),
          joinedusers: doc.get('joinedusers'),
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
