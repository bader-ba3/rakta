import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/bus_view_model.dart';
import 'package:rakta/view/bus/bus_payment.dart';

import '../../model/bus_ticket_model.dart';
import 'widget/bus_seat_widget.dart';

class BusSeatScreen extends StatefulWidget {
  final BusTicketModel busTicketModel ;
  final int persons;
  final String rate;
  const BusSeatScreen({super.key,required this.busTicketModel,required this.persons,required this.rate});

  @override
  State<BusSeatScreen> createState() => _BusSeatScreenState();
}

class _BusSeatScreenState extends State<BusSeatScreen> {
  List seat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffF0F1F3),
      backgroundColor:  Color(0xFF014f86),
      body: Stack(
        children: [
          Container(
            color:  Color(0xFF014f86),
            height: MediaQuery.sizeOf(context).height/4,
            width: MediaQuery.sizeOf(context).width,
          ),
          SafeArea(child: Column(
            children: [
              Row(
                children: [
                  BackButton(color: Colors.white,),
                  Spacer(),
                  Text("Bus Seat",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
                  SizedBox(width: 50,),
                  Spacer(),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 5,),
                      Row (
                        children: [
                          SizedBox(
                              child: Center(child: Text(widget.busTicketModel.from!,style: TextStyle(color: Colors.white54,fontSize: 22),))),
                          Spacer(),
                          SizedBox(

                              child: Center(child: Text(widget.busTicketModel.to!,style: TextStyle(color: Colors.white54,fontSize: 22),))),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row (
                        children: [
                          SizedBox(
                              width:80,
                              child: Center(child: Text(widget.busTicketModel.fromDateTime!,style: TextStyle(color: Colors.white,fontSize: 22),))),
                          Expanded(child: Container(height: 2,color: Colors.white,)),
                          SizedBox(width: 5,),
                          Text("3 H",style: TextStyle(color: Colors.white70,fontSize: 22),),
                          SizedBox(width: 5,),
                          Expanded(child: Container(height: 2,color: Colors.white,)),
                          SizedBox(
                              width:80,
                              child: Center(child: Text(widget.busTicketModel.toDateTime!,style: TextStyle(color: Colors.white,fontSize: 22),))),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Text("Date: ",style: TextStyle(fontSize: 22,color: Colors.white),),
                            Text(widget.busTicketModel.date!,style: TextStyle(fontSize: 22,color: Colors.white),),
                            Spacer(),
                            Text("Rate: ",style: TextStyle(fontSize: 20,color: Colors.white),),
                            Text(widget.rate,style: TextStyle(fontSize: 20,color: Colors.white),),
                            Icon(Icons.star,color: Colors.amber.shade700,size: 30,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Expanded(
                        child: ListView(
                          children: [
                            BusSeatWidget(
                              persons:widget.persons,
                              onChooseSeat: (List<int> seats) {
                              seat = seats;
                              widget.busTicketModel.seatNumber = seats;
                              setState((){});
                              },),
                            SizedBox(height: 40,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
          if(seat.isNotEmpty)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: InkWell(
                onTap: (){
                  Get.to(()=>BusPaymentScreen(busTicketModel: widget.busTicketModel,));
                },
                child: Container(
                  height: 50,
                  width: 150,
                 decoration: BoxDecoration( color:Color(0xFF014f86),borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text("Next",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
