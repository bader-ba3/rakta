// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
// import 'package:rakta/taxi/utils/app_style.dart';
// import 'package:rakta/taxi/utils/bindings.dart';
// import 'package:rakta/taxi/views/splash/loading_page.dart';
//
// import 'firebase_options.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Orders Service',
//       initialBinding: GetBinding(),
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: primary),
//         useMaterial3: true,
//       ),
//       home: const LoadingPage(),
//     );
//   }
// }
