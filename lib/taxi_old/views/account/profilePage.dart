// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
//
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:rakta/taxi/views/account/widget/custom_Drop_down.dart';
//
//
//
// import '../../utils/app_layout.dart';
// import '../../utils/app_style.dart';
// import '../../../view/widgets/app_Bottom.dart';
// import '../widgets/custom_text_filed.dart';
//
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(left: 25, right: 25, top: 50),
//         child: ListView(
//           children: [
//             Center(
//               child: Text(
//                 "Your Profile",
//                 style: Styles.headLineStyle1.copyWith(
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(40),
//             ),
//             Center(
//               child: Stack(
//                 children: [
//                   CircleAvatar(
//                     maxRadius: 60,
//                     backgroundColor: Colors.grey.shade300,
//                     child: Image.asset(
//                       "assets/person.png",
//                       scale: 7,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 5,
//                     right: 5,
//                     child: Container(
//                       height: 25,
//                       width: 25,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle, color: Colors.grey.shade700),
//                       child: const Center(
//                         child: Icon(
//                           Icons.edit_outlined,
//                           color: Colors.white,
//                           size: 15,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const CustomTextFiled(label: "Name", hint: "Enter your full name"),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             IntlPhoneField(
//               decoration: InputDecoration(
//                 isDense: true,
//                 contentPadding:
//                     const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                 hintText: 'Enter Phone Number',
//                 hintStyle: Styles.headLineStyle3.copyWith(
//                   fontSize: 14,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(color: Colors.black)),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 /* border: OutlineInputBorder(
//                   borderSide: BorderSide(),
//                 ),*/
//               ),
//               initialCountryCode: 'AE',
//               onChanged: (phone) {
//                 // print(phone.completeNumber);
//               },
//               onCountryChanged: (country) {
//                 // print('Country changed to: ${country.code}');
//               },
//             ),
//             const CustomTextFiled(label: "Email", hint: "Enter your full name"),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             CustomDropDown(
//                 title: "Gender",
//                 items: const [
//                   DropdownMenuEntry(
//                     value: "Male",
//                     label: "Male",
//                   ),
//                   DropdownMenuEntry(value: "Female", label: "Female"),
//                 ],
//                 hint: "Select"),
//             SizedBox(
//               height: AppLayout.getHeight(25),
//             ),
//             const AppButton(label: "Update")
//           ],
//         ),
//       ),
//     );
//   }
// }
