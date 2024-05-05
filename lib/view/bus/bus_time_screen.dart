import 'dart:math';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';
import 'package:rakta/model/bus_ticket_model.dart';
import 'package:rakta/view/bus/bus_seat_screen.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

class BusTimeScreen extends StatefulWidget {
  final BusTicketModel busTicketModel ;
  const BusTimeScreen({super.key,required this.busTicketModel});

  @override
  State<BusTimeScreen> createState() => _BusTimeScreenState();
}

class _BusTimeScreenState extends State<BusTimeScreen> with SingleTickerProviderStateMixin{
  late TabController tabController;

  late AutoScrollController autoScrollController;
  @override
  void initState() {
    int initIndex = DateTime.parse(DateTime.now().toString().split(" ")[0]).difference(DateTime.parse(widget.busTicketModel.date!)).inDays.abs();
    tabController = TabController(length: 100, vsync: this,initialIndex: initIndex);
    autoScrollController = AutoScrollController();
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    autoScrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Stack(
        children: [
          Container(
            color:  Color(0xFF014f86),
            height: MediaQuery.sizeOf(context).height/4,
            width: MediaQuery.sizeOf(context).width,
          ),
          SafeArea(child:
          Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height/4 - MediaQuery.viewPaddingOf(context).top,
                child: Column(
                  children: [
                    Row(
                      children: [
                        BackButton(color: Colors.white,),
                        Spacer(),
                        Text("Time Table",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                        SizedBox(width: 50,),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Row (
                            children: [
                              SizedBox(
                                  width:80,
                                  child: Center(child: Text("From",style: TextStyle(color: Colors.white54,fontSize: 22),))),
                              Spacer(),
                              SizedBox(
                                  width:80,
                                  child: Center(child: Text("To",style: TextStyle(color: Colors.white54,fontSize: 22),))),
                            ],
                          ),
                          Row(
                            children: [
                             Center(child: Text(widget.busTicketModel.from!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
                              Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                              Expanded(child: Container(color: Colors.white,height: 2,)),
                              Icon(Icons.directions_bus,color: Colors.grey,),
                              Expanded(child: Container(color: Colors.white,height: 2,)),
                              Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                                Center(child: Text(widget.busTicketModel.to!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    TabBar(
                      isScrollable: true,
                      controller: tabController,
                      indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      indicatorColor: Colors.white,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorWeight: 3.0,
                      tabAlignment: TabAlignment.start,
                      tabs: List.generate(100,(index) {
                        if(index ==0) {
                          return Tab(text: "Today");
                        }
                        if(index ==1) {
                          return Tab(text: "Tomorrow");
                        }
                        return Tab(text: DateTime.now().add(Duration(days: index)).toString().split(" ")[0]);
                      }).toList(),
                      onTap: (index) {
                        widget.busTicketModel.date = DateTime.now().add(Duration(days: index)).toString().split(" ")[0];
                        VerticalScrollableTabBarStatus.setIndex(index);
                      },
                    ),
                  ],
                ),
              ),
              Expanded(child: ListView.builder(
                itemCount: 6,
                itemBuilder:(context, index) {
                  int persons = Random().nextInt(46);
                  String rate = (Random().nextDouble()*2+3).toStringAsFixed(1);
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 8),
                  child: Center(child: InkWell(
                    onTap: (){
                      widget.busTicketModel.fromDateTime=(1+index).toString()+":00";
                      widget.busTicketModel.toDateTime=(4+index).toString()+":00";
                      Get.to(()=>BusSeatScreen(busTicketModel: widget.busTicketModel,persons:persons,rate:rate));
                    },
                    child: Container(
                     decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      height: 130,
                      width: MediaQuery.sizeOf(context).width/1.15,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text((1+index).toString()+":00",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color(0xFF014f86),),),
                                Spacer(),
                                Text("3 H",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.grey,),),
                                Spacer(),
                                Text((4+index).toString()+":00",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Color(0xFF014f86),),),
                                ],
                            ),
                            Spacer(),
                            Container(height: 2,width: MediaQuery.sizeOf(context).width/1.5,color: Colors.grey.shade100,),
                            Spacer(),
                            Row(
                              children: [
                                Icon(Icons.star,color: Colors.amber.shade700,),
                                SizedBox(width: 5,),
                                Text(rate),
                                Spacer(),
                                Icon(Icons.person),
                                SizedBox(width: 5,),
                                Text(persons.toString()),
                                Spacer(),
                                Text("50 AED",style: TextStyle(fontWeight: FontWeight.w700),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),),
                );
              },)),
            ],
          ))
        ],
      ),
    );
  }
}
