import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/home/home_page.dart';
import 'package:rakta/view/onboarding/onboarding.dart';
import 'core/binding.dart';
import 'firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HiveDataBase.init();
  await Permission.location.request();
  Stripe.publishableKey = 'pk_test_51P8isI08kbWqoawOtKhgnMVkCf9AKpkzSofG7IOMY7M5H0D9saYfluJP3WHHV7XYi9MtqAhsJL3IFnYkY7kZoEo300Z0AlECe0';
  Stripe.merchantIdentifier = "merchant.ba3.rakta";
  Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetBinding(),
      // home: HiveDataBase.getUserData().name=="null"?OnBoardingView():HomePage(),
      home: HomePage(),
    );
  }
}


