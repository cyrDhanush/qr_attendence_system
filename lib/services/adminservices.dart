import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/services/constants.dart';

class Adminservices {
  addnewclass(String classname, String classdescription) async {
    try {
      DocumentReference classid = await classref.add({
        'classname': classname,
        'classdescription': classdescription,
        'studentlist': [],
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
          i.id,
          i.data['classname'],
          i.data['classdescription'],
          i.data['studentlist'],
        ),
      );
    }
    return classmodellist;
  }
}
