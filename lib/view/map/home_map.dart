import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rakta/view/map/places/place_search.dart';
import '../../controller/trip_view_model.dart';
import '../../model/trip_model.dart';
import '../../utils/app_style.dart';
import '../../utils/var.dart';
import '../widgets/animation_circle.dart';
import '../widgets/location_text_filed.dart';
import 'home_View_Model.dart';

class HomeMapPage extends StatefulWidget {
  const HomeMapPage({super.key, required this.searchKey,required this.mapKey});

  @override
  State<HomeMapPage> createState() => _HomeMapPageState();
  final GlobalKey<State<StatefulWidget>> searchKey,mapKey;
}

class _HomeMapPageState extends State<HomeMapPage> {
  var initialCameraPosition = const CameraPosition(
    target: Const.locationCompany,
    zoom: 17,
  );

  PersistentBottomSheetController? bottomSheet;

  TripModel userTrip = Get.find<TripViewModel>().getUserTrip();

  TextEditingController locationController = TextEditingController();
  MapType mapType = MapType.normal;
  bool showMarker = true;
  List<LatLng> ridesPloy = const[
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
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() async {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: GetBuilder<HomeViewModel>(builder: (homeViewModel) {
        return Stack(
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              compassEnabled: true,
              zoomControlsEnabled: false,
              myLocationEnabled: true,
              initialCameraPosition: initialCameraPosition,
              mapType: mapType,
              polygons: {
                Polygon(polygonId: PolygonId("1"),
                points: ridesPloy,fillColor: Colors.green.withOpacity(0.2),strokeWidth: 2)
              },
              onCameraMove: (_){
                if(_.zoom>13.5){
                  showMarker = true;
                }else{
                  showMarker = false;
                }
                setState(() {});
              },
              onMapCreated: (controller) async {
                String mapStyle = await rootBundle.loadString('assets/map_style.json');
                controller.setMapStyle(mapStyle);
                homeViewModel.controller = Completer();
                homeViewModel.controller.complete(controller);
                homeViewModel.setMarker(const LatLng(25.784937939271234, 55.96950907868376), "bus_top", "bus1","10",size: 60);
                homeViewModel.setMarker(const LatLng(25.77788539214604, 55.93905446659033), "ferry", "ferry1","40",size: 60);
                // homeViewModel.setMarker(const LatLng(25.779292009370142, 55.943131344042804),
                homeViewModel.setMarker(const LatLng(25.789401, 55.952052), "ferry", "ferry2","-100",size: 60);
                homeViewModel.setMarker(const LatLng(25.786473, 55.947056), "images/scoter", "scoter","0",size: 100);
                homeViewModel.setMarker(const LatLng(25.789815, 55.950899), "images/scoter", "scoter2","0",size: 100);
                homeViewModel.setMarker(const  LatLng(25.786453, 55.947556), "images/bike", "bike","0",size: 100,);
                homeViewModel.setMarker(const   LatLng(25.783603, 55.944155), "images/bike", "bike2","0",size: 100,);
                homeViewModel.getDrawPolylineGreen([]);
                homeViewModel.getDrawPolylineRedLine([]);
                homeViewModel.getDrawPolylineBlue([]);
                homeViewModel.getDrawPolylinePurple([]);
                if (userTrip.tpRider == null) {
                  homeViewModel.setRiderMarker();
                } else {
                  homeViewModel.setMarker(userTrip.tpDest!.location!,
                      "location_pin", "location_pin2","0");
                  homeViewModel.setMarker(
                      userTrip.tpLocation!.last.location!,
                      "car_gry",
                      "car_gry","0");
                  homeViewModel
                      .animateCamera(userTrip.tpLocation!.last.location!);
                  homeViewModel.getDrawPolylineGreen(userTrip.tpPolyLine!);
                }
              },
              markers:showMarker? homeViewModel.markers.values.toSet():{},
              polylines: homeViewModel.polyLines,
            ),
            Positioned(
                top: 25,
                left: Get.width * 1 / 11,
                right: Get.width * 1 / 11,
                child:GestureDetector(
                    onTap: () {
                      Get.to(
                        const PlaceSearchPage(),
                      );
                    },
                    child: LocationTextFiled(
                      hint: "Choose location",
                      controller: locationController,
                    ))),
            Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      SizedBox(height:100,),
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
                              decoration:  BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                              child: Icon(
                                mapType == MapType.normal ? CupertinoIcons.building_2_fill : CupertinoIcons.arrow_counterclockwise,
                                color: Colors.amber.shade700,
                              ))),
                      SizedBox(height: 20,),
                      GestureDetector(
                          onTap: () {
                            LatLng userLatLng = LatLng(homeViewModel.userPosition!.latitude, homeViewModel.userPosition!.longitude);
                            homeViewModel.animateCamera(userLatLng);
                          },
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration:  BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade300),
                              child: Icon(
                                CupertinoIcons.location_fill,
                                color: Colors.amber.shade700,
                              ))),
                    ],
                  ),
                )),
            // if(requestRide)
            AnimatedCrossFade(
              secondChild: const SizedBox(),
              duration: const Duration(milliseconds: 200),
              crossFadeState:
              homeViewModel.currentTrip == TripStatus.waiting
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: Center(
                child: Container(
                  height: Get.height,
                  width: Get.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(.7),
                        Colors.white.withOpacity(.2),
                        Colors.transparent
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 1 / 4,
                      ),
                      const Stack(
                        children: [
                          Center(child: AnimationCircle()),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Searching Ride...",
                        style: Styles.headLineStyle3
                            .copyWith(color: Colors.black),
                      ),
                      Text(
                        "This may take a few seconds...",
                        style: Styles.headLineStyle4
                            .copyWith(color: primary),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      }),
    );
  }

}
