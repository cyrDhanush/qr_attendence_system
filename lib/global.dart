import 'package:flutter/material.dart';

// Color maincolor = Color(0xff23967F);
Color maincolor = const Color(0xff783F8E);
Color backgroundcolor = const Color(0xffFDE2FF);

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

InputDecoration textfielddecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: BorderSide(
      color: maincolor,
      width: 1.5,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: Colors.black,
      width: 1,
    ),
  ),
);
