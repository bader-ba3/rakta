// import 'package:flutter/material.dart';
// import 'package:rakta/taxi/views/history/widget/tap_widget.dart';
//
// import '../../model/trip_model.dart';
// import '../../utils/app_style.dart';
//
//
//
//
// class TripHistory extends StatefulWidget {
//   const TripHistory({super.key});
//
//   @override
//   State<TripHistory> createState() => _TripHistoryState();
// }
//
// class _TripHistoryState extends State<TripHistory> {
//   TripModel? tripModel;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       initialIndex: 0,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: const SizedBox(),
//           title: Text("Bookings",
//               style: Styles.headLineStyle1.copyWith(fontSize: 22)),
//           bottom: TabBar(
//             indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
//             indicatorSize: TabBarIndicatorSize.tab,
//             indicator: UnderlineTabIndicator(
//                 borderSide: BorderSide(width: 4.0, color: blueRak),
//                 borderRadius:
//                     const BorderRadius.vertical(top: Radius.circular(25))),
//             tabs: <Widget>[
//               Tab(
//                 icon: Text(
//                   "Active",
//                   style: Styles.headLineStyle3,
//                 ),
//               ),
//               Tab(
//                 icon: Text(
//                   "Completed",
//                   style: Styles.headLineStyle3,
//                 ),
//               ),
//               Tab(
//                 icon: Text(
//                   "Cancelled",
//                   style: Styles.headLineStyle3,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: <Widget>[
//             Center(
//               child: TapWidget(tapIndex: 0),
//             ),
//             Center(
//               child: TapWidget(tapIndex: 1),
//             ),
//             Center(
//               child: TapWidget(tapIndex: 2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
