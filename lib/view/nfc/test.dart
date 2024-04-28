// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:nfc_manager/nfc_manager.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('NFC Writer'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _startNFCWriting,
//           child: const Text('Start NFC Writing'),
//         ),
//       ),
//     );
//   }
//
//   void _startNFCWriting() async {
//     try {
//       // check if NFC is available on the device or not.
//       bool isAvailable = await NfcManager.instance.isAvailable();
//
//       // If NFC is available, start a session to listen for NFC tags.
//       if (isAvailable) {
//         NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
//           try {
//             // When an NFC tag is discovered, we check if it supports NDEF technology.
//             NdefMessage message = NdefMessage([NdefRecord.createText('Hello, NFC!')]);
//             await Ndef.from(tag)?.write(message); //If it supports NDEF, create an NDEF message and write it to the tag.
//             debugPrint('Data emitted successfully');
//             Uint8List payload = message.records.first.payload;
//             String text = String.fromCharCodes(payload);
//             debugPrint("Written data: $text");
//
//             //stop the NFC Session
//             NfcManager.instance.stopSession();
//           } catch (e) {
//             debugPrint('Error emitting NFC data: $e');
//           }
//         });
//       } else {
//         debugPrint('NFC not available.');
//       }
//     } catch (e) {
//       debugPrint('Error writing to NFC: $e');
//     }
//   }
// }
