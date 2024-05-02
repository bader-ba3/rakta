import 'dart:math';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:duration/duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Services/services.dart';
import '../../controller/payment_controller.dart';
import '../../utils/var.dart';

class BikeScreen extends StatefulWidget {
  const BikeScreen({super.key});

  @override
  State<BikeScreen> createState() => _BikeScreenState();
}

class _BikeScreenState extends State<BikeScreen> {

  List<LatLng> ridesPloy =[
    LatLng( 25.7912747,-304.0482551),
    LatLng( 25.7912619,-304.0480478),
    LatLng( 25.7909215,-304.0480725),
    LatLng( 25.7907923,-304.0481308),
    LatLng( 25.7906760,-304.0482239),
    LatLng( 25.7877250,-304.0513196),
    LatLng( 25.7876675,-304.0513460),
    LatLng( 25.7876054,-304.0513488),
    LatLng( 25.7875417,-304.0513447),
    LatLng( 25.7874809,-304.0513691),
    LatLng( 25.7874373,-304.0514257),
    LatLng( 25.7874167,-304.0514943),
    LatLng( 25.7874301,-304.0516172),
    LatLng( 25.7866998,-304.0523841),
    LatLng( 25.7865694,-304.0524559),
    LatLng( 25.7864448,-304.0525033),
    LatLng( 25.7855650,-304.0533536),
    LatLng( 25.7853482,-304.0535063),
    LatLng( 25.7852707,-304.0536276),
    LatLng( 25.7851391,-304.0537147),
    LatLng( 25.7849655,-304.0537564),
    LatLng( 25.7847044,-304.0539281),
    LatLng( 25.7845007,-304.0541508),
    LatLng( 25.7844222,-304.0542796),
    LatLng( 25.7842992,-304.0544107),
    LatLng( 25.7840864,-304.0547469),
    LatLng( 25.7839466,-304.0548866),
    LatLng( 25.7838935,-304.0550255),
    LatLng( 25.7836428,-304.0553123),
    LatLng( 25.7833976,-304.0553700),
    LatLng( 25.7832175,-304.0555587),
    LatLng( 25.7831510,-304.0556526),
    LatLng( 25.7830919,-304.0558739),
    LatLng( 25.7830063,-304.0559442),
    LatLng( 25.7829049,-304.0559817),
    LatLng( 25.7828018,-304.0560967),
    LatLng( 25.7825578,-304.0565205),
    LatLng( 25.7802473,-304.0588228),
    LatLng( 25.7799790,-304.0590626),
    LatLng( 25.7799188,-304.0591690),
    LatLng( 25.7798355,-304.0592548),
    LatLng( 25.7797296,-304.0594377),
    LatLng( 25.7792094,-304.0597568),
    LatLng( 25.7790633,-304.0598118),
    LatLng( 25.7788111,-304.0599772),
    LatLng( 25.7786575,-304.0601291),
    LatLng( 25.7785633,-304.0602887),
    LatLng( 25.7785331,-304.0604308),
    LatLng( 25.7785259,-304.0605354),
    LatLng( 25.7783990,-304.0607697),
    LatLng( 25.7782752,-304.0609352),
    LatLng( 25.7781991,-304.0609901),
    LatLng( 25.7781484,-304.0610384),
    LatLng( 25.7779793,-304.0611524),
    LatLng( 25.7779020,-304.0611363),
    LatLng( 25.7777185,-304.0612047),
    LatLng( 25.7776122,-304.0611926),
    LatLng( 25.7777197,-304.0619075),
    LatLng( 25.7780419,-304.0617111),
    LatLng( 25.7784700,-304.0613535),
    LatLng( 25.7794783,-304.0603199),
    LatLng( 25.7804675,-304.0592653),
    LatLng( 25.7824151,-304.0572714),
    LatLng( 25.7843321,-304.0552445),
    LatLng( 25.7857827,-304.0537537),
    LatLng( 25.7858183,-304.0536875),
    LatLng( 25.7858599,-304.0536497),
    LatLng( 25.7858860,-304.0536264),
    LatLng( 25.7859155,-304.0536162),
    LatLng( 25.7908223,-304.0484642),
    LatLng( 25.7908893,-304.0484797),
    LatLng( 25.7911173,-304.0483648),
    LatLng( 25.7912719,-304.0482521),

  ];
  List scooterMarkersList=[
    LatLng(25.789982, 55.950943),
    LatLng(25.788111, 55.948751),
    LatLng(25.789815, 55.950899),
    LatLng(25.786473, 55.947056),
    LatLng(25.786473, 55.947056),
    LatLng(25.778510, 55.938944),
    LatLng(25.782298, 55.942795),
  ];

  List bikeMarkersList=[
    LatLng(25.786453, 55.947556),
    LatLng(25.784289, 55.945252),
    LatLng(25.783603, 55.944155),
    LatLng(25.778608, 55.939098),
  ];
  Set<Marker> markers={};
  String rideStatus = Const.rideStatusNotStart;

  bool isSqrLoading = false;
  void onTapMarker(type){
    String dateTimeString = '';
    DateTime? startDate;
   double totalPay=0;
    showModalBottomSheet(
      context: context,
      isDismissible:rideStatus!=Const.rideStatusNotStart ,
      builder: (context) => StatefulBuilder(
      builder: (context,setstate) {
        return PopScope(
          canPop: rideStatus!=Const.rideStatusNotStart ,
          child: Container(
            height: rideStatus == Const.rideStatusStart ? 250:370,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 5,),
                Center(child: Container(width: 100,height: 5,decoration: BoxDecoration(color: Colors.grey , borderRadius: BorderRadius.circular(15)),)),
                SizedBox(height: 5,),
                if(rideStatus == Const.rideStatusNotStart)
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Icon(Icons.qr_code_scanner),
                                    SizedBox(width: 10,),
                                    Text(Random().nextInt(999999).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                    SizedBox(width: 20,),
                                    Icon(Icons.notifications_active_outlined),
                                    SizedBox(width: 10,),
                                    Text("Ring",style: TextStyle(fontSize: 20),),

                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    Text("Range: "),
                                    Text("24 KM",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                                    SizedBox(width: 5,),
                                    Icon(Icons.battery_3_bar_outlined),
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Image.asset(type =="scooter"?"assets/scooter_big.png":"assets/bike_big.png",height: 150,fit: BoxFit.fill,),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width/1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 2)),
                          child: Center(child: Text("Free Reservation",style: TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                        SizedBox(height: 20,),
                        InkWell(
                          onTap: (){
                            rideStatus = Const.rideStatusStart;
                            startDate = DateTime.now();
                            setstate((){});
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.sizeOf(context).width/1.2,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 2),color: Colors.blueAccent),
                            child: Center(child: Text("Start Trip Now",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Center(
                          child: Text("opening for 3 AED and 1 AED per minutes"),
                        )
                      ],
                    ),
                  ),
                if(rideStatus == Const.rideStatusStart)
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Center(child: StatefulBuilder(builder: (timecontext, timeState) {
                            dateTimeString = printDuration(startDate!.difference(DateTime.now()).abs()).toString();
                            Future.delayed(Duration(seconds: 1)).then((value) {
                              if (timecontext.mounted) {
                                timeState(() {});
                              }
                            });
                            return Text( dateTimeString);
                          })),
                          Center(child: StatefulBuilder(builder: (timecontext, timeState) {
                            totalPay = startDate!.difference(DateTime.now()).abs().inSeconds.toDouble() * 0.25;
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
                      SizedBox(height: 10,),
                      InkWell(
                        onTap: (){
                          rideStatus = Const.rideStatusPaying;
                          setstate((){});
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.sizeOf(context).width/1.2,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(width: 2),color: Colors.blueAccent),
                          child: Center(child: Text("End Trip",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),
                      SizedBox(height: 25,),
                    ],
                  )),

                if(rideStatus == Const.rideStatusPaying)
                  Expanded(child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                                 rideStatus = Const.rideStatusNotStart;
                                 Get.back();
                                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                   content: Text("Thank You"),
                                 ));
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
                                      rideStatus = Const.rideStatusNotStart;
                                      Get.back();
                                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                        content: Text("Thank You"),
                                      ));
                                    }
                                  }
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  )),

              ],
            ),
          ),
        );
      }
    ),);
  }
  @override
  void initState() {

    Utils().getBytesFromAsset(path: 'assets/images/scoter.png', width: 100).then((value) {
      for(var i in scooterMarkersList){
        Marker newMarker = Marker(
          markerId: MarkerId(Random().nextInt(5555555).toString()),
          icon: BitmapDescriptor.fromBytes(value),
          position: i,
          onTap: ()=>onTapMarker("scooter")
        );
        markers.add(newMarker);
        setState(() {});
      }
    });
    Utils().getBytesFromAsset(path: 'assets/images/bike.png', width: 100).then((value) {
      for(var i in bikeMarkersList){
        Marker newMarker = Marker(
          markerId: MarkerId(Random().nextInt(5555555).toString()),
          icon: BitmapDescriptor.fromBytes(value),
          position: i,
            onTap: ()=>onTapMarker("bike")

        );
        markers.add(newMarker);
        setState(() {});
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bike and Scooter reservation"),
      ),
      body: GoogleMap(
        markers: markers,
        polygons: {
          Polygon(polygonId: PolygonId("1"),
              points: ridesPloy,fillColor: Colors.green.withOpacity(0.2),strokeWidth: 2)
        },
        initialCameraPosition: CameraPosition(target: LatLng(25.785241,55.945447),zoom: 16),

      ),
    );
  }
}
