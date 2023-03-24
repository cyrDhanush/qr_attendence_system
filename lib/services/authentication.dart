import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_attendence_system/services/constants.dart';

class Authentication {
  createUser(String name, String email, String password) async {
    UserCredential user;
    try {
      user = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
      return e;
    }
    if (user.additionalUserInfo!.isNewUser) {
      userref.doc(user.user!.uid.toString()).set({
        'name': name,
        'isAdmin': false,
        'joinedclasses': {},
      });
    }
    return true;
  }

  loginUser(String email, String password) async {
    UserCredential user;
    try {
      user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e);
      return e;
    }
    // print(user.user!.uid.toString());

    return user;
    // print(user);
  }

  checkadmin(String userid) async {
    DocumentSnapshot snapshot = await userref.doc(userid).get();
    bool isAdmin = snapshot.get('isAdmin');
    return isAdmin;
  }
}
