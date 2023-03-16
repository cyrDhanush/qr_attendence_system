import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/admin_homepage.dart';
import 'package:qr_attendence_system/screens/sample.dart';
import 'package:qr_attendence_system/screens/signing/signup.dart';
import 'package:qr_attendence_system/services/authentication.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Authentication _authentication = Authentication();

  String errortext = '';
  bool obscurepassword = true;
  bool loading = false;

  login() async {
    setState(() {
      loading = true;
    });
    if (email.text != '' && password.text != '') {
      var result = await _authentication.loginUser(email.text, password.text);
      if (result.runtimeType == UserCredential) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => admin_Homepage()));
      } else if (result.toString().contains('invalid-email')) {
        setState(() {
          errortext = 'Invalid Email Format';
        });
      } else if (result.toString().contains('user-not-found')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: EdgeInsets.all(50),
            title: Text(
              'User not Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: Text(
              "Do you Want to SIGNUP ??",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(),
                child: Text(
                  "Cancel",
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => signUp()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: maincolor,
                  foregroundColor: Colors.white,
                ),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      } else if (result.toString().contains('wrong-password')) {
        setState(() {
          errortext = 'Oops, Wrong Password!!';
        });
      } else {
        setState(() {
          errortext = 'Login Successfully Failed';
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  bool rem = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => signUp()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Row(),
                        Container(
                          child: Icon(
                            Icons.qr_code_2_outlined,
                            color: Colors.redAccent,
                            size: 100,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "QR Code Scanner",
                          style: TextStyle(
                            color: maincolor,
                            fontWeight: FontWeight.bold,
                            fontSize: 35,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          height: 60,
                          child: TextField(
                            controller: email,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(
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
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60,
                                child: TextField(
                                  controller: password,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  obscureText: obscurepassword,
                                  obscuringCharacter: '*',
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
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
                            SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurepassword = !obscurepassword;
                                });
                              },
                              icon: (obscurepassword)
                                  ? (Icon(Icons.visibility_outlined))
                                  : (Icon(Icons.visibility_off_outlined)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  rem = !rem;
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: rem,
                                    shape: CircleBorder(),
                                    activeColor: maincolor,
                                    checkColor: Colors.white,
                                    onChanged: (res) {
                                      setState(() {
                                        rem = res!;
                                      });
                                    },
                                  ),
                                  Text(
                                    'Remember me',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: maincolor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextButton(
                          onPressed: (loading == true)
                              ? (null)
                              : (() {
                                  login();
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
                                  ? (CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : (Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Log in",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(
                          errortext,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
