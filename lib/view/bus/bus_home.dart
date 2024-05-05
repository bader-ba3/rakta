import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/bus_view_model.dart';
import 'package:rakta/model/bus_ticket_model.dart';
import 'package:rakta/view/bus/bus_ticket.dart';
import 'package:rakta/view/bus/bus_time_screen.dart';
import 'package:rakta/view/bus/widget/bottom_navigation_bar.dart';
import 'package:rakta/view/bus/widget/ticket_widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BusHomeScreen extends StatefulWidget {
  const BusHomeScreen({super.key});

  @override
  State<BusHomeScreen> createState() => _BusHomeScreenState();
}

class _BusHomeScreenState extends State<BusHomeScreen> {
  TextEditingController fromTextController = TextEditingController();
  TextEditingController toTextController = TextEditingController();
  DateTime? date;
  List<String> data = ['Abu Dhabi', 'Dubai', 'Sharjah', 'Ajman', 'Umm Al Quwain', 'Rak', 'Fujairah'];

  List<String> _onTextChanged(String value, String? next) {
    List<String> _ = [];
    _ = data
        .where(
          (suggestion) => suggestion.toLowerCase().startsWith(value.toLowerCase()),
        )
        .toList();
    _.removeWhere((element) => element == next);
    return _;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF0F1F3),
      body: Stack(
        children: [
          Container(
            color: Color(0xFF014f86),
            height: MediaQuery.sizeOf(context).height / 4,
            width: MediaQuery.sizeOf(context).width,
          ),
          SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    BackButton(
                      color: Colors.white,
                    ),
                    Text(
                      "Book Your Bus Now!!",
                      style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 1.2,
                    height: 400,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white, boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 20)]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 65,
                          width: 300,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.fmd_good,
                                  size: 30,
                                  color: Color(0xFF014f86),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TypeAheadField<String>(
                                controller: fromTextController,
                                suggestionsCallback: (search) => _onTextChanged(search, toTextController.text),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'From',
                                      ));
                                },
                                itemBuilder: (context, data) {
                                  return ListTile(
                                    title: Text(data),
                                  );
                                },
                                onSelected: (data) {
                                  fromTextController.text = data;
                                },
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: 65,
                          width: 300,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.location_city,
                                  size: 30,
                                  color: Color(0xFF014f86),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: TypeAheadField<String>(
                                controller: toTextController,
                                suggestionsCallback: (search) => _onTextChanged(search, fromTextController.text),
                                builder: (context, controller, focusNode) {
                                  return TextField(
                                      controller: controller,
                                      focusNode: focusNode,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'To',
                                      ));
                                },
                                itemBuilder: (context, data) {
                                  return ListTile(
                                    title: Text(data),
                                  );
                                },
                                onSelected: (data) {
                                  toTextController.text = data;
                                },
                              ))
                            ],
                          ),
                        ),
                        Container(
                          height: 65,
                          width: 300,
                          decoration: BoxDecoration(border: Border.all(color: Colors.black26), borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Icon(
                                  Icons.calendar_today,
                                  size: 30,
                                  color: Color(0xFF014f86),
                                ),
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: Colors.black26,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: InkWell(
                                onTap: () async {
                                  DateTime? _= await showDialog(
                                    context: context,
                                    builder: (context) {
                                      DateTime? _date ;
                                    return  AlertDialog(
                                        content: StatefulBuilder(
                                            builder: (context,setstate) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    height: 150,
                                                    width: MediaQuery.sizeOf(context).width,
                                                    child: EasyInfiniteDateTimeLine(
                                                      // controller: _controller,
                                                      firstDate: DateTime.now(),
                                                      focusDate: _date??date??DateTime.now(),
                                                      lastDate: DateTime.now().add(Duration(days: 100)),
                                                      onDateChange: (selectedDate) {
                                                        setstate(() {
                                                          _date = selectedDate;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                        child: InkWell(
                                                          onTap: () {
                                                            Get.back();
                                                          },
                                                          child: Container(
                                                            height: 50,
                                                            decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(8), border: Border.all()),
                                                            child: Center(
                                                              child: Text(
                                                                "Cancel",
                                                                style: TextStyle(fontSize: 18),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Expanded(
                                                          child: InkWell(
                                                            onTap: () {
                                                              Get.back(result: _date??DateTime.now());
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
                                                              child: Center(
                                                                child: Text(
                                                                  "Confirm",
                                                                  style: TextStyle(fontSize: 18),
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            }
                                        ),
                                      );
                                    },
                                  );
                                  if(_!=null){
                                    setState(() {
                                      date = _;
                                    });
                                  }

                                },
                                child: Container(
                                    child: Row(
                                  children: [
                                    Text(
                                      date != null ? (date.toString().split(" ")[0]) : "Date",
                                      style: TextStyle(color: Colors.black87),
                                    ),
                                  ],
                                )),
                              ))
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (date != null && fromTextController.text.isNotEmpty && toTextController.text.isNotEmpty && data.contains(toTextController.text) && data.contains(fromTextController.text)) {
                              BusTicketModel busTicketModel = BusTicketModel(status: true,date: date.toString().split(" ")[0].toString(),from: fromTextController.text,to: toTextController.text);
                              Get.to(() => BusTimeScreen(busTicketModel: busTicketModel,));
                            }
                          },
                          child: Container(
                            height: 65,
                            width: 300,
                            decoration: BoxDecoration(color: Color(0xFF014f86), borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Search Buses",
                                style: TextStyle(fontSize: 22, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "My Tickets",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
                )),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: GetBuilder<BusViewModel>(
                      builder: (controller) {
                        return ListView.builder(
                          reverse: true,
                                          padding: EdgeInsets.only(top: 20),
                                          itemCount: controller.userTicket.length,
                                          itemBuilder: (context, index) {
                                            BusTicketModel model = controller.userTicket[index];
                                           return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
                                              child: InkWell(
                                                onTap: () {
                                                  Get.to(() => BusTicket(
                                                    index: index,
                                                    model: model,
                                                  ));
                                                },
                                                child: Hero(
                                                  tag: "Base " + index.toString(),
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: TicketWidget(
                                                        isCornerRounded: true,
                                                        aspectRatio: 1.7,
                                                        width: 200,
                                                        height: 150,
                                                        child: Column(
                                                          children: [
                                                            Expanded(
                                                              flex: 3,
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(top: 6, left: 20, right: 20),
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                            width: 80,
                                                                            child: Center(
                                                                                child: Text(
                                                                                  "From",
                                                                                  style: TextStyle(color: Colors.black54, fontSize: 16),
                                                                                ))),
                                                                        Spacer(),
                                                                        SizedBox(
                                                                            width: 80,
                                                                            child: Center(
                                                                                child: Text(
                                                                                  "To",
                                                                                  style: TextStyle(color: Colors.black54, fontSize: 16),
                                                                                ))),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                            child: Center(
                                                                                child: Text(
                                                                                  model.from!,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                                                                ))),
                                                                        Spacer(),
                                                                        Icon(Icons.arrow_back_ios_new, color: Colors.grey, size: 15),
                                                                        Expanded(
                                                                            flex: 3,
                                                                            child: Container(
                                                                              color: Colors.grey,
                                                                              height: 1,
                                                                            )),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Icon(
                                                                          Icons.directions_bus,
                                                                          color: Colors.grey,
                                                                          size: 15,
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Expanded(
                                                                            flex: 3,
                                                                            child: Container(
                                                                              color: Colors.grey,
                                                                              height: 1,
                                                                            )),
                                                                        Icon(
                                                                          Icons.arrow_forward_ios_sharp,
                                                                          color: Colors.grey,
                                                                          size: 15,
                                                                        ),
                                                                        Spacer(),
                                                                        SizedBox(

                                                                            child: Center(
                                                                                child: Text(
                                                                                  model.to!,
                                                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
                                                                                ))),
                                                                      ],
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                        "4 hrs",
                                                                        style: TextStyle(fontSize: 11),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                                child: Center(
                                                                  child: Row(
                                                                    children: List.generate(
                                                                        45,
                                                                            (index) => Padding(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 2),
                                                                          child: Container(
                                                                            height: 2,
                                                                            width: 4,
                                                                            color: Colors.grey,
                                                                          ),
                                                                        )),
                                                                  ),
                                                                )),
                                                            Expanded(
                                                                flex: 2,
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.calendar_month_rounded,
                                                                          size: 25,
                                                                        ),
                                                                        Text(
                                                                          model.date!,
                                                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                          Icons.person,
                                                                          size: 25,
                                                                        ),
                                                                        Text(
                                                                          model.seatNumber.length.toString()+" Adults",
                                                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      model.status?"Valid":"Expired",
                                                                      style: TextStyle(color: model.status?Colors.green:Colors.red, fontSize: 18, fontWeight: FontWeight.w600),
                                                                    )
                                                                    // Text(
                                                                    //   "50 AED",
                                                                    //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                                                    // )
                                                                  ],
                                                                )),
                                                          ],
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                      }
                    ))
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Text("Inside Rak",style: TextStyle(fontSize: 22,color: Colors.blue.shade700),),
                // ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0,right: 8),
                //   child: SizedBox(
                //     height: 125,
                //     width: double.infinity,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 5,
                //       itemBuilder: (context, index) {
                //       return Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: Container(
                //           height: 125,
                //           width: 250,
                //           decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(8)),
                //           child: Row(
                //             children: [
                //               SizedBox(width: 10,),
                //               SizedBox(
                //                 width: 90,
                //                 height: 90,
                //                 child: Placeholder(),
                //               ),
                //               SizedBox(width: 10,),
                //               Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 children: [
                //                   SizedBox(height: 10,),
                //                   Text("Al Nakhil",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                //                   Spacer(),
                //                   Text("40 AED",style: TextStyle(fontSize: 16),),
                //                   SizedBox(height: 10,),
                //                 ],
                //               )
                //             ],
                //           ),
                //         ),
                //       );
                //     },),
                //   ),
                // ),
                // SizedBox(height: 20,),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                //   child: Text("Outside Rak",style: TextStyle(fontSize: 22,color: Colors.blue.shade700),),
                // ),
                // SizedBox(height: 10,),
                // Padding(
                //   padding: const EdgeInsets.only(left: 16.0,right: 8),
                //   child: SizedBox(
                //     height: 125,
                //     width: double.infinity,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: 5,
                //       itemBuilder: (context, index) {
                //         return Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Container(
                //             height: 125,
                //             width: 250,
                //             decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(8)),
                //             child: Row(
                //               children: [
                //                 SizedBox(width: 10,),
                //                 SizedBox(
                //                   width: 90,
                //                   height: 90,
                //                   child: Placeholder(),
                //                 ),
                //                 SizedBox(width: 10,),
                //                 Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     SizedBox(height: 10,),
                //                     Text("Dubai",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                //                     Spacer(),
                //                     Text("40 AED",style: TextStyle(fontSize: 16),),
                //                     SizedBox(height: 10,),
                //                   ],
                //                 )
                //               ],
                //             ),
                //           ),
                //         );
                //       },),
                //   ),
                // ),
                // SizedBox(height: 100,),
              ],
            ),
          ),
          // Column(
          //   children: [
          //     Spacer(),
          //     Center(
          //       child: Container(
          //         decoration: BoxDecoration(color: Color(0xFF014f86),borderRadius: BorderRadius.circular(50),boxShadow: [BoxShadow(color: Colors.black54,blurRadius: 20)]),
          //         width: 300,
          //         child: Center(child: BottomNavigationBarWidget()),
          //       ),
          //     ),
          //     SizedBox(height: 50,),
          //   ],
          // ),
        ],
      ),
    );
  }
}
