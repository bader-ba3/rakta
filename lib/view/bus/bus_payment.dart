import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/payment_controller.dart';
import 'package:rakta/send_review_fun.dart';
import 'package:rakta/view/bus/bus_successful_payment.dart';
import 'package:rakta/view/bus/widget/card_field_formatter.dart';

import '../../controller/bus_view_model.dart';
import '../../model/bus_ticket_model.dart';

class BusPaymentScreen extends StatefulWidget {
  final BusTicketModel busTicketModel ;
  const BusPaymentScreen({super.key,required this.busTicketModel});

  @override
  State<BusPaymentScreen> createState() => _BusPaymentScreenState();
}

class _BusPaymentScreenState extends State<BusPaymentScreen> {
int selected = 1;
TextEditingController cardNumberController = TextEditingController();
TextEditingController cardHolderController = TextEditingController();
TextEditingController cardDateController = TextEditingController();
TextEditingController cardCVCController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF0F1F3),
        elevation: 0,
        centerTitle: true,
      leading: BackButton(color: Color(0xFF014f86),),
      title: Text("Payment",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF014f86)),),),
      backgroundColor: Color(0xffF0F1F3),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(height: 10,),
                      Text("Payment Details:",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                    SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ticket",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            ...List.generate(widget.busTicketModel.seatNumber.length, (index) =>  Row(
                              children: [
                                Text("Seat no: "+widget.busTicketModel.seatNumber[index].toString()),
                                Spacer(),
                                Text("50 AED"),
                              ],
                            ),),
                            SizedBox(height: 20,),
                            Text("Fees",style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("VAT (5%)"),
                                Spacer(),
                                Text((widget.busTicketModel.seatNumber.length*50*0.05).toStringAsFixed(2)+" AED"),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                Spacer(),
                                Text(((widget.busTicketModel.seatNumber.length*50*0.05)+widget.busTicketModel.seatNumber.length*50).toStringAsFixed(2)+" AED"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    SizedBox(height: 20,),
                      Text("Pay With:",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.all(15),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  activeColor:  Color(0xFF014f86),
                                  value: 1, groupValue: selected, onChanged: (_){
                                setState((){
                                  selected=_!;
                                });
                              }),
                              // Text("Saqr Card",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                              // SizedBox(width: 10,),
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: Image.asset("assets/saqr.png",width: 60,))
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Radio(
                                  activeColor:  Color(0xFF014f86),
                                  value: 2, groupValue: selected, onChanged: (_){
                                setState((){
                                  selected=_!;
                                });
                              }),
                              // Text("Apple Pay",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                              // SizedBox(width: 10,),
                              Image.asset("assets/ApplePay.png",width: 60,)
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              Radio(
                                  activeColor:  Color(0xFF014f86),
                                  value: 3, groupValue: selected, onChanged: (_){
                                setState((){
                                  selected=_!;
                                });
                              }),
                              // Text("Credit or Debit Cards",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                              // SizedBox(width: 10,),
                              Image.asset("assets/payment.png",width: 80,)
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(selected==3)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        SizedBox(height: 20,),
                        Text("Credit or Debit Cards:",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(15),
                          width: double.infinity,
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text("Card Number: ",style: TextStyle(fontWeight: FontWeight.w600),),
                                  SizedBox(width: 5,),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    height: 45,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: cardNumberController,
                                      inputFormatters: [
                                        MaskedTextInputFormatter(
                                          mask: 'xxxx-xxxx-xxxx-xxxx',
                                          separator: '-',
                                        ),
                                      ],
                                      style: TextStyle(height: 1),
                                      decoration: InputDecoration(border: InputBorder.none),
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width:100,child: Text("Card Holder: ",style: TextStyle(fontWeight: FontWeight.w600),)),
                                  SizedBox(width: 5,),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    height: 45,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: cardHolderController,
                                      style: TextStyle(height: 1),
                                      decoration: InputDecoration(border: InputBorder.none),
                                    ),
                                  ))
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  SizedBox(width: 100,child: Text("Exp Date: ",style: TextStyle(fontWeight: FontWeight.w600),)),
                                  SizedBox(width: 5,),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    height: 45,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: cardDateController,
                                      inputFormatters: [
                                        MaskedTextInputFormatter(
                                          mask: 'xx/xx',
                                          separator: '/',
                                        ),
                                      ],
                                      style: TextStyle(height: 1),
                                      decoration: InputDecoration(border: InputBorder.none),
                                    ),
                                  )),
                                  SizedBox(width: 10,),
                                  Text("CVC: ",style: TextStyle(fontWeight: FontWeight.w600),),
                                  SizedBox(width: 5,),
                                  Expanded(child: Container(
                                    padding: EdgeInsets.only(left: 5),
                                    height: 45,
                                    decoration: BoxDecoration(border: Border.all(color: Colors.black26),borderRadius: BorderRadius.circular(8)),
                                    child: TextFormField(
                                      controller: cardCVCController,
                                      inputFormatters: [
                                        MaskedTextInputFormatter(
                                          mask: 'xxx',
                                          separator: '',
                                        ),
                                      ],
                                      style: TextStyle(height: 1),
                                      decoration: InputDecoration(border: InputBorder.none),
                                    ),
                                  )),
                                ],
                              ),
                            ],
                          ),
                        ),
                          SizedBox(height: 20,),
                      ],)
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  BusViewModel busViewModel = Get.find<BusViewModel>();
                  double amount = ((widget.busTicketModel.seatNumber.length*50*0.05)+(widget.busTicketModel.seatNumber.length*50)).toPrecision(2);
                  PaymentController paymentController = Get.find<PaymentController>();
                  if(selected==1){
                   if( paymentController.balance-amount>=0){
                     paymentController.addBalance(-amount);
                     busViewModel.addTicket(widget.busTicketModel);
                     sendReviewMessage();
                     Get.to(()=>BusSuccessfulPayment());
                   }else{
                     Get.snackbar("Error", "you don't have enough balance on your card");
                   }
                  }else if(selected ==2){
                    busViewModel.addTicket(widget.busTicketModel);
                    sendReviewMessage();
                    Get.to(()=>BusSuccessfulPayment());
                    // paymentController.handleApplePayPress(context, amount).then((value) {
                    //   if(value) {
                    //     busViewModel.addTicket(widget.busTicketModel);
                    //     Get.to(()=>BusSuccessfulPayment());
                    //   }
                    // });
                  }else{
                      if(cardNumberController.text.length==19 &&cardHolderController.text.isNotEmpty &&cardDateController.text.length==5 &&cardCVCController.text.length==3){
                        busViewModel.addTicket(widget.busTicketModel);
                        sendReviewMessage();
                        Get.to(()=>BusSuccessfulPayment());
                      }
                  }

                  // Get.to(()=>BusSuccessfulPayment());
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFF014f86),borderRadius: BorderRadius.circular(10)),
                  height: 75,
                  width: double.infinity,
                  child: Center(child: Text("Pay ${((widget.busTicketModel.seatNumber.length*50*0.05)+(widget.busTicketModel.seatNumber.length*50)).toPrecision(2)} AED",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
