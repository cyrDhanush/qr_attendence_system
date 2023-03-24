import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_attendence_system/models/classmodel.dart';
import 'package:qr_attendence_system/services/constants.dart';

class Userservices {
  getuserDetails(String userid) async {
    DocumentSnapshot snapshot = await userref.doc(userid).get();
    // print(snapshot.data().toString());
    Usermodel model = Usermodel(
      userkey: snapshot.id.toString(),
      username: snapshot.get('name'),
      joinedclasses: snapshot.get('joinedclasses'),
    );
    return model;
  }

  getclassdetail(String classcode) async {
    DocumentSnapshot snapshot = await classref.doc(classcode).get();
    print(snapshot.get('classname'));
    return snapshot;
  }

  getjoinedclasses(Map classlist) async {
    List<Classmodel> classmodellist = [];
    for (var key in classlist.keys) {
      DocumentSnapshot snapshot = await getclassdetail(key);
      print(snapshot.get('classname').toString());
      Classmodel model = Classmodel(
        classkey: snapshot.id,
        classname: snapshot.get('classname'),
        classdescription: snapshot.get('classdescription'),
        joinedusers: snapshot.get('joinedusers'),
      );
      classmodellist.add(model);
    }
    return classmodellist;
  }

  joinclass({required String classid, required String userid}) async {
    //add classid to user list
    await userref.doc(userid).set({
      'joinedclasses': {
        classid: true,
      },
    }, SetOptions(merge: true));

    // adding userid to class list

    await classref.doc(classid).set({
      'joinedusers': {
        userid: true,
      },
    }, SetOptions(merge: true));
  }

  removefromclass({required String classid, required String userid}) async {
    // removing classid from user list

    DocumentSnapshot usersnapshot = await userref.doc(userid).get();
    Map joinedclasses = usersnapshot.get('joinedclasses');
    joinedclasses.removeWhere((key, value) => key == classid);
    print(joinedclasses.toString());
    await userref.doc(userid).update(
      {
        'joinedclasses': joinedclasses,
      },
    );

    // emoving userid from class list

    DocumentSnapshot classsnapshot = await classref.doc(classid).get();
    Map joinedusers = classsnapshot.get('joinedusers');
    joinedusers.removeWhere((key, value) => key == userid);
    print(joinedusers.toString());
    await classref.doc(classid).update(
      {
        'joinedusers': joinedusers,
      },
    );
  }
}
