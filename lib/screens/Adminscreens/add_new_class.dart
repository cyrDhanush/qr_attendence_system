import 'package:flutter/material.dart';
import 'package:qr_attendence_system/global.dart';
import 'package:qr_attendence_system/services/adminservices.dart';

class add_newclass extends StatefulWidget {
  const add_newclass({Key? key}) : super(key: key);

  @override
  State<add_newclass> createState() => _add_newclassState();
}

class _add_newclassState extends State<add_newclass> {
  TextEditingController classname = TextEditingController();
  TextEditingController classdes = TextEditingController();

  Adminservices adminservices = Adminservices();
  bool loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    classname.dispose();
    classdes.dispose();
  }

  void submit() async {
    setState(() {
      loading = true;
    });
    if (classname.text != '') {
      await adminservices.addnewclass(classname.text, classdes.text);
      Navigator.pop(context);
      print("Success");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: maincolor,
          ),
        ),
        title: const Text("Add New Class"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (loading == true)
                ? (null)
                : (() {
                    submit();
                  }),
            icon: Icon(
              Icons.check,
              color: maincolor,
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Class Name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextField(
                controller: classname,
                decoration: textfielddecoration.copyWith(
                    hintText: "Class Name (Mandatory)"),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Class Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Flexible(
              child: TextField(
                controller: classdes,
                decoration: textfielddecoration.copyWith(
                    hintText: "Class Description (Optional)"),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        child: TextButton(
          onPressed: (loading == true)
              ? (null)
              : (() {
                  submit();
                }),
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: maincolor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Container(
            height: 50,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Submit",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
