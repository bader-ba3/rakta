import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/bus/widget/ticket_widget.dart';
import 'package:rakta/view/bus/widget/to_image.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:http/http.dart'as http ;
import '../../model/bus_ticket_model.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class BusTicket extends StatelessWidget {
  final BusTicketModel model ;
  final int index ;
   BusTicket({super.key, required this.model,required this.index});
  GlobalKey? keyWidget;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Details Ticket"),
        actions: [
          InkWell(
            onTap: () async {
              Uint8List imageData = await Utils.capture(keyWidget);
              var data = await FirebaseFirestore.instance.collection("whatsapp").doc("0").get();
              var token = data['token'];
              print(token);
              final String url = 'https://graph.facebook.com/v19.0/190767744131124/media';
              // final String token = 'EABkHbZCvVgEABOyCNG3UJQZCLIITZA7qYwv5W4pBts7zTal6BNUJfhkWEyEFN7ZCnPpqhSIb0BzIxcd8NlJgVPMnfZBCXAYJcYEPF84XN3YLjS8GEuOs0u3wsLCfK7823sUwaikW6XnVokmfQ0az8eKHyC0r03k5ZAtgcZBZAye8gs5dwhhAUZC0hFhc0EeD4OQ6VfvrqLsj79OcxO5aAsxMV4TcyNNnDkZCtyNcL2y94bMR4ZD';

              // Detect the mime type of the image data
              final mimeType = lookupMimeType('', headerBytes: imageData);

              // Create multipart request
              var request = http.MultipartRequest('POST', Uri.parse(url));
              request.headers['Authorization'] = 'Bearer $token';
              request.fields['messaging_product'] = 'whatsapp';
              request.files.add(
                http.MultipartFile.fromBytes(
                  'file',
                  imageData,
                  filename: 'upload.png',  // You can use any filename
                  contentType: MediaType.parse(mimeType!),
                ),
              );

              try {
                var response = await request.send();

                if (response.statusCode == 200) {
                  print('Image uploaded successfully');
                  var responseBody = await response.stream.bytesToString();
                  print(responseBody);
                  print(json.decode(responseBody)['id']);
                  sendMessage(json.decode(responseBody)['id'],token);
                } else {
                  print('Failed to upload image: ${response.statusCode}');
                  var responseBody = await response.stream.bytesToString();
                  print(responseBody);
                }
              } catch (e) {
                print('Error uploading image: $e');
              }
            },
            child: Row(
              children: [
                Text("Send Via"),
                SizedBox(width: 10,),
                Image.asset("assets/whatsapp.png",width: 25,),
              ],
            ),
          ),
        SizedBox(width: 10,)],

      ),
      backgroundColor: Color(0xFF014f86),
      body: Center(
        child: Hero(
          tag: "Base "+index.toString(),
          child: Material(
            color: Colors.transparent,
            child: WidgetToImage(
              builder: (keys) {
                keyWidget = keys;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TicketWidget(
                    width: MediaQuery.sizeOf(context).width/1,
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
                );
              }
            ),
          ),
        ),
      ),
    );
  }

  void sendMessage(imageId,token) async {
    var url = Uri.parse('https://graph.facebook.com/v19.0/190767744131124/messages');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '+token,
    };
    var body = json.encode({
      'messaging_product': 'whatsapp',
      'recipient_type': 'individual',
      'to': HiveDataBase.getUserData().mobile,
      'type': 'template',
      'template':{
        "name": "1_ticket",
        "language": {
          "code": "en_US"
        },
        "components": [
          {
            "type": "header",
            "parameters": [
              {
                "type": "image",
                "image": {
                  "id": imageId
                }
              }
            ]
          }
        ]
      }
    });

    var response = await http.post(url, headers: headers, body: body);
    print(response.body);
  }



}
