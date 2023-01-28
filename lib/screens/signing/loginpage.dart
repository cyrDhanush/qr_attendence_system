import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/admin_homepage.dart';
import 'package:qr_attendence_system/screens/signing/otppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneno_controller = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void login() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneno_controller.text.toString(),
        verificationCompleted: (a) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => admin_Homepage()));
        },
        verificationFailed: (a) {
          print("Failed");
        },
        codeSent: (String verificationid, int? token) async {
          print("Started");
          String otp = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => OTP()));
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationid, smsCode: otp);
          var a = await auth.signInWithCredential(credential);
          print("Success");
          print("Auth");
          print(a.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => admin_Homepage()));
        },
        codeAutoRetrievalTimeout: (a) {},
      );
    } catch (e) {
      print("erro occured");
      print(e.toString());
    }
  }

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
