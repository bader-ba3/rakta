import 'dart:async';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duration/duration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rakta/controller/payment_controller.dart';
import 'package:rakta/model/order_trip_model.dart';
import 'package:rakta/taxi_old/model/order_model.dart';
import 'package:rakta/view/map/places/place_search.dart';
import 'package:rakta/view/taxi/widget/dot_widget.dart';
import 'package:slider_button/slider_button.dart';
import '../../controller/trip_view_model.dart';
import '../../model/PlaceModel.dart';
import '../../model/trip_model.dart';
import '../../utils/app_style.dart';
import '../../utils/hive.dart';
import '../../utils/var.dart';
import '../map/home_View_Model.dart';
import '../widgets/animation_circle.dart';
import '../widgets/location_text_filed.dart';

class TaxiHome extends StatefulWidget {
  const TaxiHome({super.key});

  @override
  State<TaxiHome> createState() => _TaxiHomeState();
}

class _TaxiHomeState extends State<TaxiHome> {
  var initialCameraPosition = const CameraPosition(
    target: Const.locationCompany,
    zoom: 17,
  );

  PersistentBottomSheetController? bottomSheet;

  TripModel userTrip = Get.find<TripViewModel>().getUserTrip();

  TextEditingController locationController = TextEditingController();
  TextEditingController toController = TextEditingController();

  MapType mapType = MapType.normal;
LatLng? latLng;
bool isSqrLoading = false;
String dateTimeString ='';
double totalPay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Orders").doc("0").snapshots(),
        builder: (context,snapshot) {
          OrdersTripModel? ordersTripModel ;
          if(snapshot.data!=null&&snapshot.data?.data()!=null){
            ordersTripModel = OrdersTripModel.fromJson(snapshot.data!.data()!);
          }
          return GetBuilder<HomeViewModel>(builder: (homeViewModel) {
            return Stack(
              children: [
                GoogleMap(
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  zoomControlsEnabled: false,
                  myLocationEnabled: true,
                  initialCameraPosition: initialCameraPosition,
                  mapType: mapType,
                  onMapCreated: (controller) async {
                    String mapStyle = await rootBundle.loadString('assets/map_style.json');
                    controller.setMapStyle(mapStyle);
                    homeViewModel.controller = Completer();
                    LatLng userLatLng = LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude);
                    homeViewModel.animateCamera(userLatLng);
                    // homeViewModel.setMarker(
                    //     userLatLng, "location_arrow_icon", "myId","0");
                    /*    Utils().getMyLocation().then((value) {
                      print(value);

                      if (userTrip.tpRider == null) {
                        homeViewModel.animateCamera(value);
                      }
                      homeViewModel
                          .getLocationName(value)
                          .then((value) => Variables.currentLocation = value);
                      Variables.currentLoc = value;
                    });*/
                    if (userTrip.tpRider == null) {
                      homeViewModel.setRiderMarker();
                    } else {
                      homeViewModel.setMarker(userTrip.tpDest!.location!, "location_pin", "location_pin2", "0");
                      homeViewModel.setMarker(userTrip.tpLocation!.last.location!, "car_gry", "car_gry", "0");
                      homeViewModel.animateCamera(userTrip.tpLocation!.last.location!);
                      homeViewModel.getDrawPolylineGreen(userTrip.tpPolyLine!);
                    }
                  },
                  // onTap: (location) {
                  //   if (userTrip.tpRider == null) {
                  //     homeViewModel.getLocationName(location).then((value) {
                  //       if (value.places?.length != 0) {
                  //         homeViewModel.setMarker(
                  //             location, "location_pin", "anymore","0");
                  //         locationController.text = value
                  //             .places!.first.displayName!.text!
                  //             .toString();
                  //         showBottomSheet(
                  //           shape: const RoundedRectangleBorder(),
                  //           context: context,
                  //           builder: (_) {
                  //             return GestureDetector(
                  //                 onTap: () async {
                  //                   String tripId = generateId("trip");
                  //                   Get.back();
                  //                   await homeViewModel.addTip(TripModel(
                  //                     tpDest: LocationModel(
                  //                       locAdd1: value
                  //                           .places!.first.formattedAddress!,
                  //                       locName: value
                  //                           .places!.first.displayName!.text!,
                  //                       location: location,
                  //                     ),
                  //                     tpId: tripId,
                  //                     tpSrc: LocationModel(
                  //                         locName: Variables
                  //                             .currentLocation
                  //                             ?.places
                  //                             ?.first
                  //                             .displayName
                  //                             ?.text,
                  //                         locAdd1: Variables
                  //                             .currentLocation
                  //                             ?.places
                  //                             ?.first
                  //                             .formattedAddress,
                  //                         location: Variables.currentLoc),
                  //                     tpStatus: TripStatus.waiting,
                  //                     tpUser: Variables.currentUser.userId,
                  //                   ));
                  //                   //TODO:
                  //                   homeViewModel.drawPolyline(
                  //                       Variables.currentLoc!,
                  //                       location,
                  //                       tripId);
                  //                 },
                  //                 child: const ConfirmBottomSheet());
                  //           },
                  //         );
                  //       }
                  //     });
                  //   }
                  // },
                  onTap: (argument) async {
                    if(ordersTripModel==null){
                      homeViewModel.setMarker(argument, "location_pin", "marker", "0", size: 100);
                      PlaceModel places = await homeViewModel.getLocationName(argument);
                      if (places.places!.isEmpty) {
                        homeViewModel.markers.removeWhere((key,value) => value.position == argument);
                      } else {
                        print(places.places!.first.displayName!.text);
                        latLng = argument;
                        toController.text = places.places!.first.displayName!.text!;
                      }
                      setState(() {});
                    }
                  },
                  markers: homeViewModel.markers.values.toSet(),
                  polylines: homeViewModel.polyLines,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, border: Border.all(color: Colors.black26)),
                        width: MediaQuery.sizeOf(context).width / 1.15,
                        height: MediaQuery.sizeOf(context).width / (ordersTripModel?.status == Const.tripStatusTripStarted ?1.9:ordersTripModel?.status == Const.tripStatusTripPaying ?1:1.15),
                        child: StatefulBuilder(
                          builder: (context,setstate) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            if(ordersTripModel==null) {
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
                                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                                           height: 40,
                                           width: 40,
                                           child: Icon(Icons.location_on,color: Colors.amber,),
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
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                                            height: 40,
                                            width: 40,
                                            child: Icon(Icons.location_on,color: Colors.blue,),
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
                                            decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                                            width: 275,
                                            height: 50,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Center(
                                                  child: Row(
                                                children: [
                                                  Text(homeViewModel.fromAddress),
                                                ],
                                              )),
                                            )),
                                        SizedBox(
                                          height: MediaQuery.sizeOf(context).width / 6,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(border: Border.all(color: Colors.black), borderRadius: BorderRadius.circular(10)),
                                          width: 275,
                                          height: 50,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: toController,
                                                      decoration: InputDecoration.collapsed(hintText: "To"),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () async {
                                                        ({LatLng latlng, String name})? _= await  Get.to(PlaceSearchPage());
                                                        if(_!=null){
                                                          toController.text = _.name;
                                                          latLng = _.latlng;
                                                          print(_.name);
                                                          print(_.latlng);
                                                        }
                                                      },
                                                      child: Icon(Icons.search,color: Colors.amber,))
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
                                    if(toController.text.isNotEmpty&&latLng!=null&&homeViewModel.userPosition!=null) {
                                      String fromAddress =  "";
                                      await  homeViewModel.getLocationName(LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude)).then((value) => fromAddress = value.places!.first.displayName!.text!);
                                      FirebaseFirestore.instance.collection("Orders").doc("0").set({
                                      "userName":HiveDataBase.getUserData().name,
                                      "userNumber":HiveDataBase.getUserData().mobile,
                                      "fromLatLng":{"lat":homeViewModel.userPosition!.latitude,"lng":homeViewModel.userPosition!.longitude},
                                      "toLatLng": {"lat":latLng!.latitude,"lng":latLng!.longitude},
                                      "fromAddress": fromAddress,
                                      "toAddress":toController.text,
                                      "status":Const.tripStatusSearchDriver,
                                      "ploy":[],
                                    },SetOptions(merge: true));
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
                            if(ordersTripModel.status == Const.tripStatusSearchDriver) {
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
                                      child: Center(child:  Lottie.asset('assets/search_driver.json'),)),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Center(child: SliderButton(

                                      buttonColor: Colors.red.shade700,
                                      action: () async{
                                        FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                        return true;
                                      },
                                      label: Text(
                                        "Slide to cancel Order",
                                        style: TextStyle(
                                            color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                      ),
                                      icon: Center(
                                        child: Icon(Icons.close,color: Colors.white,size: 40,),
                                      ),
                                    ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if(ordersTripModel.status == Const.tripStatusWaitingDriver) {
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
                                      child: Center(child:  Lottie.asset('assets/waiting_driver.json'),),),

                                  Transform.scale(
                                    scale: 0.8,
                                    child: Center(child: SliderButton(
                                      buttonColor: Colors.red.shade700,
                                      action: () async{
                                        FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                        return true;
                                      },
                                      label: Text(
                                        "Slide to cancel Order",
                                        style: TextStyle(
                                            color: Color(0xff4a4a4a), fontWeight: FontWeight.w500, fontSize: 17),
                                      ),
                                      icon: Center(
                                        child: Icon(Icons.close,color: Colors.white,size: 40,),
                                      ),
                                    ),

                                    ),
                                  ),
                                ],
                              );
                            }
                            if(ordersTripModel.status == Const.tripStatusTripStarted){
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
                                        return Text( dateTimeString);
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
                            if(ordersTripModel.status == Const.tripStatusTripPaying){
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
                                    height: MediaQuery.sizeOf(context).width/2.2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            children: [
                                              Text("Total Time"),
                                              Spacer(),
                                              Text( dateTimeString),
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
                                              Text(totalPay.toString() + " AED"),
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
                                              Text((totalPay * 0.05).toStringAsFixed(2) + " AED"),
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
                                              Text((totalPay + (totalPay * 0.05)).toStringAsFixed(2) + " AED"),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap:() async {
                                          if(!isSqrLoading){
                                            var totalDis = (totalPay + (totalPay * 0.05));
                                            isSqrLoading = true;
                                            setstate((){});
                                            await Future.delayed(Duration(milliseconds: 1500));
                                            isSqrLoading = false;
                                            PaymentController paymentController  = Get.find<PaymentController>();
                                           double _= paymentController.balance-totalDis;
                                          if(_>0){
                                            FirebaseFirestore.instance.collection("Account").doc("0").update({"balance":_.toString()});
                                            FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                          }else{
                                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                              content: Text("you don't have enough balance"),
                                            ));
                                          }
                                            setstate(() {

                                          });

                                          }
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(color: Colors.blueAccent.shade700,borderRadius: BorderRadius.circular(8)),
                                              child: Center(child: isSqrLoading
                                              ?CircularProgressIndicator(color: Colors.white,)
                                              :Text("Saqr Card",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),)),
                                            )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                          child: ApplePayButton(
                                            onPressed: () async {
                                              double totalDis = double.parse((totalPay + (totalPay * 0.05)).toStringAsFixed(2));
                                              PaymentController paymentController  = Get.find<PaymentController>();
                                             bool _ = await paymentController.handleApplePayPress(context,totalDis);
                                             if(_){
                                               FirebaseFirestore.instance.collection("Orders").doc("0").delete();
                                             }
                                            }
                                          ),
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ],
                              );
                            }
                            else{
                              return Center(child: Text("Unknown "+ordersTripModel.status.toString()),);
                            }
                          }
                        )),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
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
                              decoration:  BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                              child: Icon(
                                mapType == MapType.normal ? CupertinoIcons.building_2_fill : CupertinoIcons.arrow_counterclockwise,
                                color: Colors.amber.shade700,
                              ))),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                          onTap: () =>Get.back(),
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration:  BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.amber.shade700,
                              ))),
                    )),
              ],
            );
          });
        }
      ),
    );
  }
}
