import 'package:flutter/material.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/bus/widget/ticket_widget.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../model/bus_ticket_model.dart';

class BusTicket extends StatelessWidget {
  final BusTicketModel model ;
  final int index ;
  const BusTicket({super.key, required this.model,required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details Ticket"),
      ),
      backgroundColor: Color(0xFF014f86),
      body: Center(
        child: Hero(
          tag: "Base "+index.toString(),
          child: Material(
            color: Colors.transparent,
            child: TicketWidget(
              width: MediaQuery.sizeOf(context).width/1.1,
              height: MediaQuery.sizeOf(context).height/1.5,
              isCornerRounded: true,
              aspectRatio: 1.5,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                    Expanded(flex:9,child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row (
                              children: [
                                SizedBox(
                                    width:80,
                                    child: Center(child: Text("From",style: TextStyle(color: Colors.black,fontSize: 22),))),
                                Spacer(),
                                SizedBox(
                                    width:80,
                                    child: Center(child: Text("To",style: TextStyle(color: Colors.black,fontSize: 22),))),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    child: Center(child: Text(model.from!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),))),
                                Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 15),
                                Expanded(child: Container(color: Colors.black,height: 1,)),
                                Icon(Icons.directions_bus,color: Colors.grey,),
                                Expanded(child: Container(color: Colors.black,height: 1,)),
                                Icon(Icons.arrow_forward_ios_sharp,color: Colors.black,size: 15,),
                                SizedBox(
                                    child: Center(child: Text(model.to!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),))),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: List.generate(43, (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Container(height: 2,width: 4,color: Colors.grey,),
                          )),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Passengers",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text(model.seatNumber.length.toString()+" Adults",style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Seats No",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text(model.seatNumber.join(","),style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ticket No",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text("42WLd94",style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Passenger Name",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text(HiveDataBase.getUserData().name,style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Ticket Fare",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600),),
                                SizedBox(height: 5,),
                                Text("50 AED",style: TextStyle(fontWeight: FontWeight.w600),)
                              ],
                            ),
                            SizedBox(),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Center(child: Text("Ticket Status: CONFIRMED"),)
                      ],
                    )),
                    Expanded(child: Center(
                      child: Row(
                       children: List.generate(43, (index) => Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 2),
                         child: Container(height: 2,width: 4,color: Colors.grey,),
                       )),
                      ),
                    )),
                    Expanded(flex: 4,child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [Text("show this to the Driver of the bus"),
                        Container(
                          height: 100,
                          child: SfBarcodeGenerator(
                              value: 'Ba3.co'),
                        )
                      ],
                    ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
