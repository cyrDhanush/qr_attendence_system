import 'package:flutter/material.dart';

class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  @override
  String value = '';

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter OTP"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < value.length; i++) otpcontainer(value[i]),
                  for (int i = 0; i < 6 - value.length; i++) otpcontainer(" "),
                ],
              ),
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    button("1"),
                    button("2"),
                    button("3"),
                  ],
                ),
                Row(
                  children: [
                    button("4"),
                    button("5"),
                    button("6"),
                  ],
                ),
                Row(
                  children: [
                    button("7"),
                    button("8"),
                    button("9"),
                  ],
                ),
                Row(
                  children: [
                    cancelbutton(),
                    button("0"),
                    okbutton(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget otpcontainer(String i) {
    return Container(
      height: 60,
      width: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(30),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        i,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget cancelbutton() {
    return Expanded(
      child: TextButton(
        onLongPress: () {
          setState(() {
            value = "";
          });
        },
        onPressed: () {
          if (value.length != 0) {
            setState(() {
              value = value.substring(0, value.length - 1);
            });
          }
        },
        style: TextButton.styleFrom(),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Icon(Icons.backspace_rounded),
        ),
      ),
    );
  }

  Widget okbutton() {
    return Expanded(
      child: TextButton(
        onPressed: () {
          Navigator.pop(context, value);
        },
        style: TextButton.styleFrom(),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Icon(Icons.check_circle_rounded),
        ),
      ),
    );
  }

  Widget button(id) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            if (value.length < 6) {
              value += id;
            }
          });
        },
        style: TextButton.styleFrom(),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            id,
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
