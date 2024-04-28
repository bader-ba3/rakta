// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
//
// class ProfileSettingPage extends StatelessWidget {
//   const ProfileSettingPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         leading: const SizedBox(),
//         title: Text(
//           "Profile",
//           style: Styles.headLineStyle2.copyWith(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
//         child: Column(
//           children: [
//             Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     maxRadius: 50,
//                     backgroundColor: Colors.grey.shade300,
//                     child: Image.asset(
//                       "assets/person.png",
//                       scale: 7,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     right: 0,
//                     child: Container(
//                       height: 29,
//                       width: 29,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white, width: 2),
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 10)
//                           ],
//                           shape: BoxShape.circle,
//                           color: Colors.grey.shade700),
//                       child: const Center(
//                         child: Icon(
//                           Icons.edit_outlined,
//                           color: Colors.white,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(8),
//             ),
//             Center(
//                 child: Text(
//               "ENG.Ali Dabol",
//               style: Styles.headLineStyle2,
//             )),
//             SizedBox(
//               height: AppLayout.getHeight(15),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: profileButton.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             Icon(
//                               profileButton[index]['icon'],
//                               color: primary,
//                               size: 32,
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               profileButton[index]['text'],
//                               style: Styles.headLineStyle2.copyWith(
//                                 color: Colors.black.withOpacity(0.7),
//                                 fontWeight: FontWeight.normal,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             const Spacer(),
//                             Icon(
//                               Icons.arrow_forward_ios_outlined,
//                               color: primary,
//                             )
//                           ],
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         Divider(color: primary.withOpacity(0.2)),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// List<Map<String, dynamic>> profileButton = [
//   {"icon": Icons.person, "text": "Your Profile"},
//   {"icon": Icons.location_on, "text": "Manage Address"},
//   {"icon": Icons.notifications_none_outlined, "text": "Notification"},
//   {"icon": Icons.payment_outlined, "text": "Payment Methods"},
//   {"icon": Icons.calendar_month_outlined, "text": "Pre-Booked Rides"},
//   {"icon": Icons.settings_outlined, "text": "Settings"},
//   {"icon": Icons.emergency_outlined, "text": "Emergency Contact"},
//   {"icon": Icons.help_center_outlined, "text": "Help Center"},
// ];
