import 'dart:math' as math;

import 'package:circular_menu/circular_menu.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/main_view_model.dart';
import 'package:rakta/view/bike/bike_screen.dart';
import 'package:rakta/view/bus/search_page_bus.dart';
import 'package:rakta/view/card/card.dart';
import 'package:rakta/view/home/home.dart';
import 'package:rakta/view/map/places/place_search.dart';
import 'package:rakta/view/profile/profile.dart';
import 'package:rakta/view/taxi/taxi_home.dart';

import '../map/home_map.dart';

//#ba8c0a
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<GlobalKey<State<StatefulWidget>>> keys =
  List.generate(6, (index) => GlobalKey());
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainViewModel>(
      builder: (controller) {
        return Scaffold(
          floatingActionButton:CircularMenu(
            radius: 100,
            animationDuration: Duration(milliseconds: 300),
            toggleButtonColor: Color(0xFF014f86),
              startingAngleInRadian: 1.15 * math.pi,
              endingAngleInRadian: 1.85 * math.pi,
              items: [
            CircularMenuItem(
                onTap:(){
                  Get.to(()=>BikeScreen());
                },
                color: Colors.white,
                // border: Border.all(color: Colors.black),
                widget: Image.asset("assets/bike.png",width: 35,height: 35)),
            CircularMenuItem(
                    color: Colors.white,
                    // border: Border.all(color: Colors.black),
                    widget: Image.asset("assets/boat.png",width: 35,height: 35), onTap: () {
                  //callback
                }),
            CircularMenuItem(
              onTap:(){
                Get.to(()=>TaxiHome());
              },
              color: Colors.white,
                // border: Border.all(color: Colors.black),
                widget: Image.asset("assets/car.png",width: 35,height: 35),
                ),
            CircularMenuItem(
                color: Colors.white,
                // border: Border.all(color: Colors.black),
                widget: Image.asset("assets/bus.png",width: 35,height: 35), onTap: () {
              Get.to(()=>SearchScreenBus());
            }),
          ]),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: CurvedNavigationBar(
            index: 2,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.transparent,
            color: Colors.transparent,
            height: 75,
            items:  <Widget>[
              Image.asset(
                color: controller.index == 0 ?Color(0xFF014f86):null,
                height: 30,
                  width: 30,
                  "assets/Home.png"
              ),
              Image.asset(
                  color: controller.index == 1 ?Color(0xFF014f86):null,
                  height: 30,
                  width: 30,
                  "assets/Map.png"
              ),
              SizedBox(
                width: 100,
              ),
              Image.asset(
                  color: controller.index == 2 ?Color(0xFF014f86):null,
                  height: 30,
                  width: 30,
                  "assets/Card.png"
              ),
              Image.asset(
                  color: controller.index == 3 ?Color(0xFF014f86):null,
                  height: 30,
                  width: 30,
                  "assets/User.png"
              ),
            ],
            onTap: (index) {
              if(index !=2){
                pageController.jumpToPage(index);
                controller.updateIndex(index);
              }
            },
          ),

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: pageController,
          children: [
            Home(),
            HomeMapPage(
              searchKey: keys[0],mapKey:keys[1],
            ),
            Center(child: Text("Map")),
            CardView(),
            ProfileView()
          ],
        ),
        );
      }
    );
  }

}

