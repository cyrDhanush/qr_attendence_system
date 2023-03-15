import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/screens/Adminscreens/add_new_class.dart';
import 'package:qr_attendence_system/screens/Adminscreens/admin_homepage.dart';
import 'package:qr_attendence_system/screens/Adminscreens/class_page.dart';
import 'package:qr_attendence_system/screens/Adminscreens/studentlist.dart';
import 'package:qr_attendence_system/bin/qr_scanning_screen.dart';
import 'package:qr_attendence_system/screens/Userscreens/userHomepage.dart';
import 'package:qr_attendence_system/screens/sample.dart';
import 'package:qr_attendence_system/screens/welcome_page.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorSchemeSeed: maincolor,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 7,
        ),
      ),
      // home: add_newclass(),
      // home: WelcomePage(),
      // home: admin_Homepage(),
      // home: classPage(),
      // home: studentList(),

      home: userHomepage(),

      // home: addusers(),
    );
  }
}
