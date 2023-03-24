import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';

class loadingScreen extends StatelessWidget {
  const loadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 230,
          width: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Loading',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: maincolor.withAlpha(50),
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
    );
  }
}
