import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/bus_view_model.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BusViewModel>(
      builder: (controller) {
        return BottomBar(
          backgroundColor:Colors.transparent,
          selectedIndex: controller.index,
          onTap: controller.updateIndex,
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
                activeColor: Colors.white,
                backgroundColorOpacity: 1,
                activeTitleColor: Color(0xff042F40),
                activeIconColor: Color(0xff042F40),
                inactiveColor: Colors.white
            ),
            BottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favorites'),
              activeColor: Colors.white,
              backgroundColorOpacity: 1,
              activeTitleColor: Color(0xff042F40),
              activeIconColor: Color(0xff042F40),
              inactiveColor: Colors.white
            ),
            BottomBarItem(
              icon: Icon(Icons.person),
              title: Text('Account'),
                activeColor: Colors.white,
                backgroundColorOpacity: 1,
                activeTitleColor: Color(0xff042F40),
                activeIconColor: Color(0xff042F40),
                inactiveColor: Colors.white
            ),
          ],
        );
      }
    );
  }
}
