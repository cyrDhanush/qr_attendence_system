import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/admin_homepage.dart';
import 'package:qr_attendence_system/screens/Userscreens/userHomepage.dart';
import 'package:qr_attendence_system/screens/sample.dart';
import 'package:qr_attendence_system/screens/signing/signup.dart';
import 'package:qr_attendence_system/services/authentication.dart';
import 'package:qr_attendence_system/services/localauthentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  Authentication _authentication = Authentication();
  localAuthentication localauth = localAuthentication();
  late SharedPreferences prefs;
  String? prefemail;
  String? prefpassword;

  String errortext = '';
  bool obscurepassword = true;
  bool loading = false;
  bool remember = true;

  login({bool localauth = false}) async {
    String email, password;
    setState(() {
      loading = true;
    });
    if (localauth == true) {
      email = prefemail!;
      password = prefpassword!;
    } else {
      email = emailcontroller.text;
      password = passwordcontroller.text;
    }
    if (email != '' && password != '') {
      print('started');
      var result = await _authentication.loginUser(email, password);
      print('logging in');
      if (result.runtimeType == UserCredential) {
        // credentials are correct
        // storing into local storage
        if (remember == true) {
          prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', email);
          await prefs.setString('password', password);
        }
        bool isadmin = await _authentication.checkadmin(result.user!.uid);
        if (isadmin == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const admin_Homepage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => userHomepage(
                userkey: result.user!.uid,
              ),
            ),
          );
        }
      } else if (result.toString().contains('invalid-email')) {
        setState(() {
          errortext = 'Invalid email Format';
        });
      } else if (result.toString().contains('user-not-found')) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            contentPadding: const EdgeInsets.all(50),
            title: const Text(
              'User not Found',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            content: const Text(
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
                child: const Text(
                  "Cancel",
                  style: TextStyle(),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const signUp()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: maincolor,
                  foregroundColor: Colors.white,
                ),
                child: const Text(
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

  getpreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefemail = prefs.getString('username');
    prefpassword = prefs.getString('password');
    setState(() {});
  }

  clearstoredlogin() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
    getpreferences();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getpreferences();
  }

  bool rem = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const signUp()));
                    },
                    child: const Text(
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
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
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
                            controller: emailcontroller,
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
                                  controller: passwordcontroller,
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
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  remember =
                                      (remember == true) ? (false) : (true);
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.only(right: 15),
                              ),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: remember,
                                    shape: const CircleBorder(),
                                    activeColor: maincolor,
                                    checkColor: Colors.white,
                                    onChanged: (res) {},
                                  ),
                                  const Text(
                                    'Remember Me',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: (prefemail != null) ? (true) : (false),
                          child: Container(
                            height: 35,
                            child: OutlinedButton(
                              onPressed: () async {
                                bool result = await localauth.authenticate(
                                    reason: 'Please Authenticate to Login');
                                if (result == true) {
                                  print(prefpassword);
                                  login(localauth: true);
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    'Login as ' + prefemail.toString() + ' ?',
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      clearstoredlogin();
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
                                  ? (const CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                  : (Container(
                                      height: 60,
                                      alignment: Alignment.center,
                                      child: const Text(
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
            ],
          ),
        ),
      ),
    );
  }
}
