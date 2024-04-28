
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakta/view/bus/textFiled_icon.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_style.dart';
import 'app_bottom.dart';
import 'bus.dart';
import 'date_picker.dart';

class SearchScreenBus extends StatefulWidget {
  const SearchScreenBus({super.key});

  @override
  State<SearchScreenBus> createState() => _SearchScreenBusState();
}

class _SearchScreenBusState extends State<SearchScreenBus> {
  final TextEditingController depController = TextEditingController();

  final TextEditingController arriveController = TextEditingController();

  final TextEditingController depTimeController = TextEditingController();

  final TextEditingController arriveTimeController = TextEditingController();

  double? heading = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 160,
            left: 0,
            right: 0,
            bottom: 0,
           child:    Container(
                color: Colors.white,
                height: Get.height,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Styles.secondaryColor),
                          color: Colors.white
                        // color: Colors.red
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(left: 5.0, right: 0),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                    ...List.generate(
                                        8,
                                            (index) => Container(
                                          height: 3,
                                          width: 5,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 3),
                                          decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              shape: BoxShape.circle),
                                        )),
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    TextFiledIcon(
                                      listItem:
                                      [],
                                      controller: depController,
                                      text: "Form",
                                      icon: Icons.flight_takeoff_outlined,
                                    ),
                                    const Padding(
                                      padding:
                                      EdgeInsets.only(left: 18.0, right: 5),
                                      child: Divider(),
                                    ),
                                    TextFiledIcon(
                                      listItem:
                                      [],
                                      controller: arriveController,
                                      text: "To",
                                      icon: Icons.flight_land_outlined,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 55,
                            right: 15,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border:
                                  Border.all(color: Styles.secondaryColor)
                                  ),
                              padding: const EdgeInsets.all(3),
                              child: Transform.rotate(
                                angle: 1.56,
                                child: Image.asset(
                                  "assets/exchange.png",
                                  height: 25,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppLayout.getHeight(20)),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Styles.secondaryColor),
                          color: Colors.white
                        // color: Colors.red
                      ),
                      child: Column(
                        children: [
                          DatePicker(
                            controller: depTimeController,
                            text: "Departure ",
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text("Today",style: Styles.headLineStyle3.copyWith(color: Colors.black),),
                              ),
                              const  SizedBox(
                                width: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black,width: 1),
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text("Tomorrow",style: Styles.headLineStyle3.copyWith(color: Colors.black),),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppLayout.getHeight(30)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: AppBottom(
                        text: "Find ticket",
                        onTap: () async {
                          // print((heading! * (pi / 100) * -1));
                          Get.to(const BusPage());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Text("Right to Full Refund and 0 commission",style: Styles.headLineStyle4.copyWith(fontSize: 12),textAlign: TextAlign.center,),
                    ),
                  ],
                ),
              ),
          ),
          Positioned(
            top: 50,
            right: 10,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/logo-wide.png",
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 30,
            right: 30,
            child: Container(
              height: 70,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // border: Border.all(color: Styles.secondaryColor),
                  color: Colors.white
                  // color: Colors.red
                  ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.directions_bus_filled_outlined,
                            color: Colors.white,
                          ),
                          Text(
                            "Buses",
                            style: Styles.headLineStyle4.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.car_crash_outlined,
                            color: primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Taxi",
                            style: Styles.headLineStyle4.copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.directions_ferry_outlined,
                            color: primary,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Ferry",
                            style: Styles.headLineStyle4.copyWith(
                                color: Colors.grey.shade800,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
