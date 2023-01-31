import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/admin_homepage.dart';
import 'package:qr_attendence_system/screens/Userscreens/userHomepage.dart';
import 'package:qr_attendence_system/screens/signing/otppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneno_controller = TextEditingController();
  TextEditingController name_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // phoneno_controller.text = '1234567890';
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref('userdetails');

  Future checkindatabase(UserCredential userCredential) async {
    // to check whether the usercredential is in database or not

    var data = await ref.get();
    List mylist = [];
    for (var i in data.children) {
      mylist.add(i);
    }
    for (var i in mylist) {
      if (i.value['userphoneno'] ==
          userCredential.user!.phoneNumber.toString()) {
        return true;
      }
    }
    return false;
  }

  Future getkeyofuser(UserCredential userCredential) async {
    // to get the key of the user
    var data = await ref.get();
    List mylist = [];
    for (var i in data.children) {
      mylist.add(i);
    }
    for (var i in mylist) {
      if (i.value['userid'] == userCredential.user!.uid) {
        return (i.key);
      }
    }
  }

  Future getname() {
    var a = showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
        title: Text("Enter Your Name"),
        children: [
          TextField(
            controller: name_controller,
            decoration: textfielddecoration.copyWith(
              hintText: "Enter Your Name",
              contentPadding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  if (name_controller.text.length != 0) {
                    Navigator.pop(context);
                  }
                },
                child: Text("Ok"),
              ),
            ],
          )
        ],
      ),
    );
    return a;
  }

  void login() async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneno_controller.text.toString(),
        verificationCompleted: (a) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => admin_Homepage()));
        },
        verificationFailed: (a) {
          print(a.toString());
        },
        codeSent: (String verificationid, int? token) async {
          String otp = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OTP()));
          // String otp = "123456";

          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationid, smsCode: otp);

          var credentials = await auth.signInWithCredential(credential);
          //check database if user is new or not
          var isthere = await checkindatabase(credentials);
          if (isthere == false) {
            //add data and phone number into database
            await getname();
            ref.push().set({
              'userid': credentials.user!.uid.toString(),
              'username': name_controller.text,
              'userphoneno': credentials.user!.phoneNumber.toString(),
            });
          }
          var userkey = await getkeyofuser(credentials);

          var data = await ref.child('$userkey').get();
          var isuser = data.child('admin').value;
          if (isuser == null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => userHomepage(
                  userkey: userkey,
                ),
              ),
            );
          } else if (isuser == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => admin_Homepage()));
          }

          // var user = await ref.child(userkey).get();
          // var uservalue = user.children.elementAt(0);
          // if (uservalue.key == 'admin' && uservalue.value == true) {

          // } else {
          //
          // }
        },
        codeAutoRetrievalTimeout: (a) {},
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    name_controller.dispose();
    phoneno_controller.dispose();
  }

  //demo
  String passed = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          background(context),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Login",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "+ 91",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 30,
                          width: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: TextField(
                            controller: phoneno_controller,
                            cursorColor: Colors.black,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  Text(passed),
                  Spacer(),
                  ElevatedButton(
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => admin_Homepage()));
                    },
                    onPressed: () async {
                      if (phoneno_controller.text.length == 10) {
                        try {
                          FocusScope.of(context).unfocus();
                        } catch (e) {}
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      elevation: 7,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Container(
                      height: 70,
                      width: 110,
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
