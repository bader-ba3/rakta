// // ignore_for_file: file_names
//
// import 'package:flutter/material.dart';
//
// import '../../../utils/app_layout.dart';
// import '../../../utils/app_style.dart';
//
// // ignore: must_be_immutable
// class CustomDropDown extends StatelessWidget {
//   CustomDropDown(
//       {super.key,
//       required this.title,
//       required this.items,
//       required this.hint});
//
//   String title, hint;
//   List<DropdownMenuEntry<String>> items;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style:
//               Styles.headLineStyle3.copyWith(fontSize: 14, color: Colors.black),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(
//           height: AppLayout.getHeight(2),
//         ),
//         LayoutBuilder(builder: (context, con) {
//           return DropdownMenu<String>(
//             width: con.maxWidth,
//             textStyle: Styles.textStyle,
//             inputDecorationTheme: InputDecorationTheme(
//                 isDense: true,
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: const BorderSide(color: Colors.black),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey.shade300),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                 floatingLabelBehavior: FloatingLabelBehavior.never),
//             hintText: hint,
//             menuStyle: MenuStyle(
//               shape: MaterialStateProperty.all(
//                 const RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(10),
//                   ),
//                 ),
//               ),
//               backgroundColor: MaterialStateProperty.all(Colors.grey.shade400),
//               shadowColor: MaterialStateProperty.all(Colors.grey.shade400),
//               elevation: MaterialStateProperty.all(15),
//             ),
//             onSelected: (String? value) {},
//             dropdownMenuEntries: items,
//           );
//         }),
//       ],
//     );
//   }
// }
