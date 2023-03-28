import 'package:flutter/material.dart';

loadingBlock({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 30),
      content: Container(
        height: 50,
        width: 50,
        child: FittedBox(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        ),
      ),
    ),
  );
}
