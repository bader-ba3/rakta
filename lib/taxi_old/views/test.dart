// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class Tests extends StatefulWidget {
//   const Tests({super.key});
//
//   @override
//   State<Tests> createState() => _TestsState();
// }
//
// class _TestsState extends State<Tests> {
//   late WebViewController controller;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//
//           onProgress: (int progress) {
//             // Update loading bar.
//             print(progress);
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://www.google.com/maps/@25.78868009217173, 55.943085866624365&travelmode=walking'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: WebViewWidget(controller: controller),
//     );
//   }
// }
//
//
// // IconButton(
// // icon: const Icon(Icons.navigation),
// // onPressed: () async {
// // try {
// // const String googleMapsUrl =
// // 'google.navigation:q=25.78868009217173, 55.943085866624365';
// //
// // const String fallbackUrl =
// // 'https://maps.apple.com/?q=25.78868009217173,55.943085866624365';
// //
// // if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
// // await launchUrl(Uri.parse(googleMapsUrl));
// // } else {
// // await launchUrl(Uri.parse(fallbackUrl));
// // }
// // // await launchUrl(Uri.parse(
// // //     "google.navigation:q=25.78868009217173, 55.943085866624365&travelmode=walking"));
// // } on Exception catch (e) {
// // print(e);
// // }
// // },
// // ),