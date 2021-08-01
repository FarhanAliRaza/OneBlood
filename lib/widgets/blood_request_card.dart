import 'package:flutter/material.dart';
import 'package:one_blood/contants.dart';

// class DonorsCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       child: Container(
//         child: Row(children: [
//           Expanded(
//             flex: 2,
//             child:
//                 Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Icon(
//                 Icons.person,
//                 size: 50,
//                 color: KonsecColor,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 4),
//                 child: Text(
//                   "${widget.blood}",
//                   style: TextStyle(
//                       color: KonsecColor, fontWeight: FontWeight.w600),
//                   textAlign: TextAlign.center,
//                 ),
//               )
//             ]),
//           ),
//           Expanded(
//             flex: 4,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 10.0),
//                   child: Text(
//                     "Name : ${widget.name}",
//                     style: TextStyle(
//                       color: KonsecColor,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "Distance :  ${dis ~/ 1000} KM",
//                   style: TextStyle(color: KonsecColor),
//                 )
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: 100,
//                   child: GestureDetector(
//                     onTap: () {
//                       launch("tel://0${widget.phone}");
//                     },
//                     child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(color: KonsecColor, width: 2),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0))),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(
//                               Icons.call,
//                               color: KonsecColor,
//                             ),
//                             SizedBox(width: 5),
//                             Text(
//                               "Call",
//                               style: TextStyle(
//                                   color: KonsecColor,
//                                   fontWeight: FontWeight.w600),
//                             ),
//                           ],
//                         )),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ]),
//         height: 120.0,
//         margin: const EdgeInsets.only(bottom: 6, top: 5),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           // border: Border.all(color: KonsecColor, width: 2),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               offset: Offset(0.0, 1.0), //(x,y)
//               blurRadius: 6.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
