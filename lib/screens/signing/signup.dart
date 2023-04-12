import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/sample.dart';
import 'package:qr_attendence_system/screens/signing/loginwithemail.dart';
import 'package:qr_attendence_system/services/authentication.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String errortext = '';
  bool obscurepassword = true;
  Authentication _authentication = Authentication();
  bool loading = false;

  bool validate() {
    if (email.text != '' && name.text != '' && password.text != '') {
      //signup
      return true;
    } else {
      setState(() {
        errortext = '';
        if (email.text == '') {
          errortext += 'Enter Email Id\n';
        }
        if (name.text == '') {
          errortext += 'Enter Name\n';
        }
        if (password.text == '') {
          errortext += 'Enter Password Id\n';
        }
      });
      return false;
    }
  }

  showSuccess() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Sign Up Successfull'),
        content: const Text('You can Login Now'),
        contentPadding: const EdgeInsets.all(30),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Go to Login Page'),
          ),
        ],
      ),
    );
  }

  signup() async {
    setState(() {
      loading = true;
    });
    var result =
        await _authentication.createUser(name.text, email.text, password.text);
    if (result.runtimeType == bool && result == true) {
      //success
      await showSuccess();

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    } else if (result.toString().contains('email-already-in-use')) {
      setState(() {
        errortext = 'Email Already in Use\nTry Logging in';
      });
    } else {
      setState(() {
        errortext = 'Sign up successfully Failed';
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Row(),
                      Container(
                        child: const Icon(
                          Icons.qr_code_2_outlined,
                          color: Colors.redAccent,
                          size: 100,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "QR Attendance",
                        style: TextStyle(
                          color: maincolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 60,
                        child: TextField(
                          controller: name,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: maincolor,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: maincolor,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 60,
                        child: TextField(
                          controller: email,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: maincolor,
                                width: 1,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: maincolor,
                                width: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 60,
                              child: TextField(
                                controller: password,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                                obscureText: obscurepassword,
                                obscuringCharacter: '*',
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 18,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: maincolor,
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: maincolor,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                obscurepassword = !obscurepassword;
                              });
                            },
                            icon: (obscurepassword)
                                ? (const Icon(Icons.visibility_outlined))
                                : (const Icon(Icons.visibility_off_outlined)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextButton(
                        onPressed: (loading == true)
                            ? (null)
                            : (() {
                                if (validate() == true) {
                                  signup();
                                }
                              }),
                        style: TextButton.styleFrom(
                          backgroundColor: maincolor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (loading == true)
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: (const CircularProgressIndicator(
                                      color: Colors.white,
                                    )),
                                  )
                                : (Container(
                                    height: 60,
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        errortext,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
