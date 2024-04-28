import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:gif/gif.dart';
import 'package:rakta/view/base/button_widget.dart';
import 'package:rakta/view/home/home_page.dart';

import '../auth/auth_screen.dart';
import '../home/home.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> with TickerProviderStateMixin {
  int index = 0;
  List<double> carIndex = [0, 1 / 3, 2 / 3, 1];
  List<({String title, String body})> data = [
    (title: "Welcome to RAKTA", body: "Explore Ras Al Khaimah's transportation options and manage your Saqr card with ease."),
    (title: "Discover Transportation", body: "Explore taxis, buses, and ferries in Ras Al Khaimah. Plan your journeys with ease."),
    (title: "Manage Your Saqr Card", body: "Check your balance, top up, and view transaction history for your Saqr card."),
    (title: "Book Transportation", body: "Book taxis, buses, and ferries directly from the app. Travel hassle-free in Ras Al Khaimah"),
  ];
  late GifController controller;
  @override
  void initState() {
    controller = GifController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF696969),
      backgroundColor: Color(0xff03488c),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -350,
              right: 20,
              left: -200,
              child: CircleAvatar(
                radius: 350,
                backgroundColor: Colors.blue,
              ),
            ),
            Positioned(
              bottom: -350,
              right: -200,
              left: -100,
              child: CircleAvatar(
                radius: 300,
                backgroundColor: Colors.blue,
              ),
            ),
            Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              )
                            ], color: Colors.white.withOpacity(1), borderRadius: BorderRadius.circular(20)),
                            child: Image.asset(
                              "assets/logo-wide.png",
                              width: MediaQuery.sizeOf(context).width / 1.2,
                            )),
                      ],
                    )),
                Spacer(),
                Container(
                  height: 180,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          data[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        data[index].body,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Transform.scale(
                    scale: 1.5,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Center(
                        child: Gif(
                          fps: 60,
                          image: AssetImage("assets/car_land.gif"),
                          controller: controller,
                          autostart: Autostart.no,
                          placeholder: (context) => const Text(''),
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        //   color: Colors.transparent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: index > 0
                                ? () {
                                    controller.animateTo(carIndex[index - 1]);
                                    index--;
                                    setState(() {});
                                  }
                                : null,
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: index > 0
                                    ? [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        )
                                      ]
                                    : null,
                              ),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Back",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 25),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            flex: 2,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: index != 3
                                  ? () {
                                      controller.animateTo(carIndex[index + 1]);
                                      index++;
                                      setState(() {});
                                    }
                                  : () {
                                      controller.dispose();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HomePage(),
                                          ),
                                          (route) => false);
                                    },
                              child: index == 3
                                  ? AuthScreen()
                                  : Container(
                                      height: 80,
                                      decoration: BoxDecoration(boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        )
                                      ], borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            index != 3 ? "Next" : "Login",
                                            style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w400, fontSize: 30),
                                          ),
                                          index != 3
                                              ? Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.blue.shade800,
                                                  size: 30,
                                                )
                                              : Image.asset(
                                                  "assets/UAEPASS.png",
                                                  width: 40,
                                                )
                                        ],
                                      )),
                                    ),
                            )),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
