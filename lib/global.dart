import 'package:flutter/material.dart';

Color maincolor = Color(0xff23967F);
Color backgroundcolor = Color(0xffFDE2FF);

Opacity background(context) {
  return Opacity(
    opacity: 0.3,
    child: Container(
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        "assets/login_background.jpg",
        fit: BoxFit.cover,
      ),
    ),
  );
}
