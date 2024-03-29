import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qr_attendence_system/screens/loadingblock.dart';

class fingerprint extends StatefulWidget {
  const fingerprint({Key? key}) : super(key: key);

  @override
  State<fingerprint> createState() => _fingerprintState();
}

class _fingerprintState extends State<fingerprint> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            loadingBlock(
              context: context,
            );
            print('Started');
            await Future.delayed(const Duration(seconds: 5));
            print('ended');
            Navigator.pop(context);
          },
          child: const Text('Finger Print'),
        ),
      ),
    );
  }
}
