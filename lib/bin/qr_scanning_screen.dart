// import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
// import 'package:qr_attendence_system/global.dart';
// // import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class qr_scanning extends StatefulWidget {
//   const qr_scanning({Key? key}) : super(key: key);
//
//   @override
//   State<qr_scanning> createState() => _qr_scanningState();
// }
//
// class _qr_scanningState extends State<qr_scanning> {
//   GlobalKey globalKey = GlobalKey();
//   // QRViewController? qrViewController;
//   var qrresult = "Scan the code";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: true,
//         title: Text("Scan the QR Code"),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Container(
//               height: 200,
//               width: 200,
//               // child: QRView(
//               //   key: globalKey,
//               //   onQRViewCreated: (QRViewController controller) {},
//               // ),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   final a = await FlutterBarcodeScanner.scanBarcode(
//                       '#783F8E', "Cancel", false, ScanMode.QR);
//                   print(a);
//                   setState(() {
//                     qrresult = a;
//                   });
//                 },
//                 child: Container(),
//               ),
//             ),
//             Text(qrresult.toString()),
//           ],
//         ),
//       ),
//     );
//   }
// }
