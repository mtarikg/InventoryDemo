// import 'package:flutter/material.dart';
//
// class AlertDialog {
//   alertComplete(BuildContext context, String title, String content,
//       dynamic pageToNavigate) {
//     Widget okButton = TextButton(
//         onPressed: () {
//           Navigator.of(context, rootNavigator: true).pop();
//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => pageToNavigate),
//               (route) => false);
//         },
//         child: const Text("OK"));
//
//     var alertDialog = AlertDialog(
//       title: Text(title),
//       content: Text(content),
//       actions: [okButton],
//     );
//
//     showDialog(
//         context: context, builder: (BuildContext context) => alertDialog);
//   }
// }
