// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:hex/hex.dart';
// import 'package:nfc_manager/nfc_manager.dart';
// import 'package:nfc_manager/platform_tags.dart';
// import 'package:ndef/ndef.dart' as ndefPackage;
//
//
//
// class MyApp2 extends StatelessWidget {
//   const MyApp2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//    MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NFC Reader'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _startNFCReading,
//           child: const Text('Start NFC Reading'),
//         ),
//       ),
//     );
//   }
//
//   void _startNFCReading() async {
//     try {
//       bool isAvailable = await NfcManager.instance.isAvailable();
//
//       //We first check if NFC is available on the device.
//       if (isAvailable) {
//         //If NFC is available, start an NFC session and listen for NFC tags to be discovered.
//         NfcManager.instance.startSession(
//           onDiscovered: (NfcTag tag) async {
//             debugPrint('NFC Tag Detected: ${tag.data}');
//             debugPrint('NFC Tag Detected: ${tag.handle}');
//             Ndef? ndef = Ndef.from(tag);
//            print(ndef?.cachedMessage);// Process NFC tag, When an NFC tag is discovered, print its data to the console.
//            print(ndef?.additionalData);// Process NFC tag, When an NFC tag is discovered, print its data to the console.
//            print(ndef?.isWritable);// Process NFC tag, When an NFC tag is discovered, print its data to the console.
//            print(ndef?.maxSize);// Process NFC tag, When an NFC tag is discovered, print its data to the console.
//             print((tag.data['ndef']['cachedMessage']['records']));
//             print((tag.data['ndef']['cachedMessage']['records'][0]['payload']));
//             List<int> a=((tag.data['ndef']['cachedMessage']['records'][0]['payload']));
//
//             for (var e in a) {
//               print(String.fromCharCode(e));
//
//             }
//
//           },
//         );
//
//
//       } else {
//         debugPrint('NFC not available.');
//       }
//     } catch (e) {
//       debugPrint('Error reading NFC: $e');
//     }
//   }
// }