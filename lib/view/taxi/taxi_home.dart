import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duration/duration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rakta/controller/payment_controller.dart';
import 'package:rakta/model/order_trip_model.dart';
import 'package:rakta/send_review_fun.dart';
import 'package:rakta/view/map/places/place_search.dart';
import 'package:rakta/view/taxi/widget/dot_widget.dart';
import 'package:slider_button/slider_button.dart';
import '../../controller/trip_view_model.dart';
import '../../model/PlaceModel.dart';
import '../../model/trip_model.dart';
import '../../utils/hive.dart';
import '../../utils/var.dart';
import '../map/home_View_Model.dart';
import 'package:http/http.dart' as http;

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome> createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  var initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 17,
  );

  PersistentBottomSheetController? bottomSheet;

  TripModel userTrip = Get.find<TripViewModel>().getUserTrip();

  TextEditingController locationController = TextEditingController();
  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();

  MapType mapType = MapType.normal;
  LatLng? fromLatLng;
  LatLng? toLatLng;
  bool isSqrLoading = false;
  bool isAppleLoading = false;
  String dateTimeString = '';
  double totalPay = 0;
  bool showMarker = true;
  bool isSelectFrom = false;
  bool isInit = false;
  @override
  void initState() {
    HomeViewModel homeViewModel = Get.find<HomeViewModel>();
    fromController.text = homeViewModel.fromAddress;
    fromLatLng = LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude);
    super.initState();
  }

  @override
  void dispose() {
    HomeViewModel homeViewModel = Get.find<HomeViewModel>();
    homeViewModel.markers.removeWhere((key, value) => key.value.contains("marker"));

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Orders").doc("0").snapshots(),
          builder: (context, snapshot) {
            OrdersTripModel? ordersTripModel;
            if (snapshot.data != null && snapshot.data?.data() != null) {
              ordersTripModel = OrdersTripModel.fromJson(snapshot.data!.data()!);
            }
            return GetBuilder<HomeViewModel>(builder: (homeViewModel) {
              return Stack(
                children: [
                  StatefulBuilder(builder: (context, mapState) {
                    return GoogleMap(
                      myLocationButtonEnabled: false,
                      compassEnabled: true,
                      zoomControlsEnabled: false,
                      myLocationEnabled: true,
                      initialCameraPosition: initialCameraPosition,
                      mapType: mapType,
                      onCameraMove: (_) {
                        if (_.zoom > 13.5) {
                          showMarker = true;
                        } else {
                          showMarker = false;
                        }
                        mapState(() {});
                      },
                      onMapCreated: (controller) async {
                        String mapStyle = await rootBundle.loadString('assets/map_style.json');
                        controller.setMapStyle(mapStyle);
                        homeViewModel.taxiController = Completer();
                        homeViewModel.taxiController.complete(controller);
                        LatLng userLatLng = LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude);
                        homeViewModel.animateCameraTaxi(userLatLng);
                        if (userTrip.tpRider == null) {
                          homeViewModel.setRiderMarker();
                        } else {
                          homeViewModel.setMarker(userTrip.tpDest!.location!, "location_pin", "location_pin2", "0");
                          homeViewModel.setMarker(userTrip.tpLocation!.last.location!, "car_gry", "car_gry", "0");
                          homeViewModel.animateCamera(userTrip.tpLocation!.last.location!);
                          homeViewModel.getDrawPolylineGreen(userTrip.tpPolyLine!);
                        }
                      },
                      onTap: (argument) async {
                        if (ordersTripModel == null) {
                          if (isSelectFrom) {
                            homeViewModel.setMarker(argument, "location_icon", "marker_from", "0", size: 100);
                            PlaceModel places = await homeViewModel.getLocationName(argument);
                            if (places.places!.isEmpty) {
                              homeViewModel.markers.removeWhere((key, value) => value.position == argument);
                              fromController.clear();
                              fromLatLng = null;
                            } else {
                              fromLatLng = argument;
                              fromController.text = places.places!.first.displayName!.text!;
                              isSelectFrom = false;
                              setState(() {});
                            }
                          } else {
                            homeViewModel.setMarker(argument, "location_pin", "marker_to", "0", size: 100);
                            PlaceModel places = await homeViewModel.getLocationName(argument);
                            if (places.places!.isEmpty) {
                              homeViewModel.markers.removeWhere((key, value) => value.position == argument);
                              toLatLng = null;
                              toController.clear();
                            } else {
                              toLatLng = argument;
                              toController.text = places.places!.first.displayName!.text!;
                            }
                          }
                          setState(() {});
                        }
                      },
                      markers: showMarker ? homeViewModel.markers.values.toSet() : {},
                      polylines: homeViewModel.polyLines,
                    );
                  }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, border: Border.all(color: Colors.black26)),
                          width: MediaQuery.sizeOf(context).width / 1.15,
                          height: MediaQuery.sizeOf(context).width /
                              (ordersTripModel?.status == Const.tripStatusTripStarted
                                  ? 1.9
                                  : ordersTripModel?.status == Const.tripStatusTripPaying
                                      ? 1
                                      : 1.15),
                          child: StatefulBuilder(builder: (context, setstate) {
                            if (!isInit&&snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            isInit = true;
                            if (ordersTripModel == null) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                      child: Text(
                                    "Start Trip",
                                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                                  )),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 40,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.black)),
                                              height: 40,
                                              width: 40,
                                              child: Icon(
                                                Icons.location_on,
                                                color: Colors.amber,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.sizeOf(context).width / 5,
                                              child: DotWidget(
                                                dashColor: Colors.black,
                                                dashHeight: 5,
                                                dashWidth: 2,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), border: Border.all(color: Colors.black)),
                                              height: 40,
                                              width: 40,
                                              child: Icon(
                                                Icons.location_on,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black), color: Colors.grey.withOpacity(isSelectFrom ? 0.2 : 0), borderRadius: BorderRadius.circular(10)),
                                            width: 275,
                                            height: 50,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        enabled: false,
                                                        controller: fromController,
                                                        decoration: InputDecoration.collapsed(hintText: "From"),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          ({LatLng latlng, String name})? _ = await Get.to(PlaceSearchPage());
                                                          if (_ != null) {
                                                            fromController.text = _.name;
                                                            fromLatLng = _.latlng;
                                                            isSelectFrom = false;
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.search,
                                                          color: Colors.amber,
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          isSelectFrom = true;
                                                          setstate(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.location_on,
                                                          color: Colors.amber,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.sizeOf(context).width / 6,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black), color: Colors.grey.withOpacity(isSelectFrom ? 0 : 0.2), borderRadius: BorderRadius.circular(10)),
                                            width: 275,
                                            height: 50,
                                            child: Center(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        enabled: false,
                                                        controller: toController,
                                                        decoration: InputDecoration.collapsed(hintText: "To"),
                                                      ),
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          ({LatLng latlng, String name})? _ = await Get.to(PlaceSearchPage());
                                                          if (_ != null) {
                                                            toController.text = _.name;
                                                            toLatLng = _.latlng;
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.search,
                                                          color: Colors.amber,
                                                        )),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    InkWell(
                                                        onTap: () async {
                                                          isSelectFrom = false;
                                                          setstate(() {});
                                                        },
                                                        child: Icon(
                                                          Icons.location_on,
                                                          color: Colors.amber,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (toController.text.isNotEmpty && toLatLng != null && fromController.text.isNotEmpty && fromLatLng != null) {
                                        // String fromAddress =  "";
                                        // await  homeViewModel.getLocationName(LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude)).then((value) => fromAddress = value.places!.first.displayName!.text!);
                                        FirebaseFirestore.instance.collection("Orders").doc("0").set({
                                          "userName": HiveDataBase.getUserData().name,
                                          "userNumber": HiveDataBase.getUserData().mobile,
                                          // "fromLatLng":{"lat":homeViewModel.userPosition!.latitude,"lng":homeViewModel.userPosition!.longitude},
                                          "toLatLng": {"lat": toLatLng!.latitude, "lng": toLatLng!.longitude},
                                          "fromLatLng": {"lat": fromLatLng!.latitude, "lng": fromLatLng!.longitude},
                                          "fromAddress": fromController.text,
                                          "toAddress": toController.text,
                                          "status": Const.tripStatusSearchDriver,
                                          "ploy": [],
                                        }, SetOptions(merge: true));
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(10)),
                                      height: 50,
                                      width: MediaQuery.sizeOf(context).width / 1.5,
                                      child: Center(
                                          child: Text(
                                        "Search",
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                                      )),
                                    ),
                                  )
                                ],
                              );
                            }
                            if (ordersTripModel.status == Const.tripStatusSearchDriver) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                      "Waiting Driver to Accepte",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                                    )),
                                  ),
                                  SizedBox(
                                      height: MediaQuery.sizeOf(context).width / 3,
                                      child: Center(
                                        child: Lottie.asset('assets/search_driver.json'),
                                      )),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Center(
                                      child: SliderButton(
                                        buttonColor: Colors.red.shade700,
                                        action: () async {
                                          FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                          return true;
                                        },
                                        label: Text(
                                          "Slide to cancel Order",
                                          style: TextStyle(color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                        ),
                                        icon: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (ordersTripModel.status == Const.tripStatusWaitingDriver) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                      "Waiting For The Driver to arrive",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                                    )),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).width / 3,
                                    child: Center(
                                      child: Lottie.asset('assets/waiting_driver.json'),
                                    ),
                                  ),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Center(
                                      child: SliderButton(
                                        buttonColor: Colors.red.shade700,
                                        action: () async {
                                          FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                          return true;
                                        },
                                        label: Text(
                                          "Slide to cancel Order",
                                          style: TextStyle(color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                        ),
                                        icon: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (ordersTripModel.status == Const.tripStatusTripStarted) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                      "Trip is Started",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                                    )),
                                  ),
                                  Column(
                                    children: [
                                      Center(child: StatefulBuilder(builder: (timecontext, timeState) {
                                        dateTimeString = printDuration(ordersTripModel!.date!.difference(DateTime.now()).abs()).toString();
                                        Future.delayed(Duration(seconds: 1)).then((value) {
                                          if (timecontext.mounted) {
                                            timeState(() {});
                                          }
                                        });
                                        return Text(dateTimeString);
                                      })),
                                      Center(child: StatefulBuilder(builder: (timecontext, timeState) {
                                        totalPay = ordersTripModel!.date!.difference(DateTime.now()).abs().inSeconds.toDouble() * 0.25;
                                        Future.delayed(Duration(seconds: 3)).then((value) {
                                          if (timecontext.mounted) {
                                            timeState(() {});
                                          }
                                        });
                                        return SizedBox(
                                          height: MediaQuery.sizeOf(context).width / 5,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                                decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(15)),
                                                child: AnimatedFlipCounter(
                                                  thousandSeparator: ",",
                                                  decimalSeparator: ".",
                                                  fractionDigits: 2,
                                                  duration: Duration(milliseconds: 500),
                                                  value: totalPay,
                                                  suffix: " AED",
                                                  textStyle: TextStyle(fontSize: 40),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      })),
                                    ],
                                  ),
                                ],
                              );
                            }
                            if (ordersTripModel.status == Const.tripStatusTripPaying) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Center(
                                        child: Text(
                                      "The Trip Ended",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 30),
                                    )),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.sizeOf(context).width / 2.2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Total Time"),
                                              Spacer(),
                                              Text(dateTimeString),
                                            ],
                                          ),
                                          Container(
                                            height: 2,
                                            color: Colors.grey.shade300,
                                          ),
                                          Row(
                                            children: [
                                              Text("subtotal"),
                                              Spacer(),
                                              Text(ordersTripModel.total.toString() + " AED"),
                                            ],
                                          ),
                                          Container(
                                            height: 2,
                                            color: Colors.grey.shade300,
                                          ),
                                          Row(
                                            children: [
                                              Text("Add 5% VAT"),
                                              Spacer(),
                                              Text((ordersTripModel.total! * 0.05).toStringAsFixed(2) + " AED"),
                                            ],
                                          ),
                                          Container(
                                            height: 2,
                                            color: Colors.grey.shade300,
                                          ),
                                          Row(
                                            children: [
                                              Text("Total"),
                                              Spacer(),
                                              Text((ordersTripModel.total! + (ordersTripModel.total! * 0.05)).toStringAsFixed(2) + " AED"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: isSqrLoading
                                            ? null
                                            : () async {
                                                double totalDis = double.parse((ordersTripModel!.total! + (ordersTripModel.total! * 0.05)).toStringAsFixed(2));
                                                isSqrLoading = true;
                                                setstate(() {});
                                                await Future.delayed(Duration(milliseconds: 1500));
                                                isSqrLoading = false;
                                                PaymentController paymentController = Get.find<PaymentController>();
                                                double _ = paymentController.balance - totalDis;
                                                if (_ > 0) {
                                                  FirebaseFirestore.instance.collection("Account").doc("0").update({"balance": _.toString()});
                                                  FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                                  sendReviewMessage();
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                    content: Text("you don't have enough balance"),
                                                  ));
                                                }
                                                setstate(() {});
                                              },
                                        child: Center(
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: Container(
                                                height: 50,
                                                width: double.infinity,
                                                decoration: BoxDecoration(color: Colors.blueAccent.shade700, borderRadius: BorderRadius.circular(8)),
                                                child: Center(
                                                    child: isSqrLoading
                                                        ? CircularProgressIndicator(
                                                            color: Colors.white,
                                                          )
                                                        : Text(
                                                            "Saqr Card",
                                                            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                                          )),
                                              )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      StatefulBuilder(builder: (context, appleSetState) {
                                        return Center(
                                          child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                              child: isAppleLoading
                                                  ? Container(
                                                      height: 48,
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                                                      child: Center(
                                                        child: CircularProgressIndicator(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  : InkWell(
                                                onTap: ()async{
                                                  isAppleLoading=true;
                                                  appleSetState(() {});
                                                  await Future.delayed(Duration(seconds: 2));
                                                  isAppleLoading=false;
                                                  appleSetState(() {});
                                                  FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                                  sendReviewMessage();
                                                },
                                                      child: Container(
                                                        height: 48,
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Icon(
                                                                Icons.apple,
                                                                color: Colors.white,
                                                              ),
                                                              Text(
                                                                "Apple Pay",
                                                                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                              // :ApplePayButton(
                                              //   onPressed:isAppleLoading?null: () async {
                                              //     isAppleLoading=true;
                                              //     appleSetState(() {});
                                              //     double totalDis = double.parse((ordersTripModel!.total! + (ordersTripModel.total! * 0.05)).toStringAsFixed(2));
                                              //     PaymentController paymentController  = Get.find<PaymentController>();
                                              //    bool _ = await paymentController.handleApplePayPress(context,totalDis);
                                              //     isAppleLoading=false;
                                              //     appleSetState(() {});
                                              //    if(_){
                                              //      FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                              //        sendReviewMessage();
                                              //    }
                                              //   }
                                              // ),
                                              ),
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return Center(
                                child: Text("Unknown " + ordersTripModel.status.toString()),
                              );
                            }
                          })),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  if (mapType == MapType.normal) {
                                    mapType = MapType.hybrid;
                                  } else {
                                    mapType = MapType.normal;
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                    child: Icon(
                                      mapType == MapType.normal ? CupertinoIcons.building_2_fill : CupertinoIcons.arrow_counterclockwise,
                                      color: Colors.amber.shade700,
                                    ))),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                                onTap: () {
                                  LatLng userLatLng = LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude);
                                  homeViewModel.animateCameraTaxi(userLatLng);
                                },
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                    child: Icon(
                                      CupertinoIcons.location_fill,
                                      color: Colors.amber.shade700,
                                    ))),
                          ],
                        ),
                      )),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.amber.shade700,
                                ))),
                      )),
                ],
              );
            });
          }),
    );
  }
}
