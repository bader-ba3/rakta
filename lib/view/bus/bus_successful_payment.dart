import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

class BusSuccessfulPayment extends StatelessWidget {
  const BusSuccessfulPayment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Gif(
                image: AssetImage("assets/images/payment_check.gif"),
                autostart: Autostart.once,
              ),
              SizedBox(height: 10,),
              Text("Payment Successful!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text("Your Payment is Processed and your ticket is confirmed",textAlign: TextAlign.center,),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    Get.back();
                    Get.back();
                    Get.back();
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xFF014f86),borderRadius: BorderRadius.circular(10)),
                    height: 75,
                    width: double.infinity,
                    child: Center(child: Text("View Tickets",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
