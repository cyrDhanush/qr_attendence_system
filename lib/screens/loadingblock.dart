import 'package:flutter/material.dart';

loadingBlock({required BuildContext context, bool exitable = false}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => WillPopScope(
      onWillPop: () async {
        return exitable;
      },
      child: const AlertDialog(
        contentPadding: EdgeInsets.symmetric(vertical: 30),
        content: SizedBox(
          height: 50,
          width: 50,
          child: FittedBox(
            child: CircularProgressIndicator(
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    ),
  );
}
