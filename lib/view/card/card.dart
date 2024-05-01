import 'package:flip/flip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:glass/glass.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:rakta/controller/payment_controller.dart';

import 'payment.dart';

class CardView extends StatelessWidget {
  CardView({super.key});
  FlipController flipController = FlipController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Card",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<PaymentController>(
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    flipController.flip();
                  },
                  child: Container(
                    // decoration: BoxDecoration(boxShadow: [BoxShadow(color: Colors.red)]),
                    child: Flip(
                      controller: flipController,
                      flipDirection: Axis.horizontal,
                      flipDuration: Duration(milliseconds: 200),
                      firstChild: ClipRRect(borderRadius: BorderRadius.circular(15), child: Container(
                          // decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color)]),
                          child: Image.asset("assets/saqr.png"))),
                      secondChild: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset("assets/saqr_back.png")), //背面的控件
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),image: DecorationImage(image: AssetImage('assets/Shot.png'), fit: BoxFit.fill)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              height: 100,
                              width: double.infinity,
                              child: Center(child: Row(
                                children: [
                                  SizedBox(width: 20,),
                                  GlowIcon(
                                  Icons.account_balance_wallet,
                                    color: Colors.blue,
                                    glowColor: Colors.blue,
                                    size: 64,
                                    blurRadius: 9,
                                  ),
                                SizedBox(width: 30,),
                                  Text("Your Balance: ${controller.balance.toStringAsFixed(2)} AED",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                ],
                              )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap:(){
                                Get.to(()=>PaymentScreen());
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                child: Center(child: Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    GlowIcon(
                                      Icons.add_card,
                                      color: Colors.blue,
                                      glowColor: Colors.blue,
                                      size: 64,
                                      blurRadius: 9,
                                    ),
                                    SizedBox(width: 30,),
                                    Text("Add Balance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                  ],
                                )),
                              ).asGlass(
                                  tintColor: Colors.transparent,
                                  clipBorderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap:(){
                                print("{object}");
                              },
                              child: Container(height: 100, width: double.infinity,
                                child: Center(child: Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    GlowIcon(
                                      Icons.text_snippet,
                                      color: Colors.blue,
                                      glowColor: Colors.blue,
                                      size: 64,
                                      blurRadius: 9,
                                    ),
                                    SizedBox(width: 30,),
                                    Text("Payment history",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                  ],
                                )),
                              ).asGlass(
                                tintColor: Colors.transparent,
                                  clipBorderRadius: BorderRadius.circular(15)
                              ),
                            ),
                            // SizedBox(
                            //   height: 20,
                            // ),
                            // InkWell(
                            //   borderRadius: BorderRadius.circular(15),
                            //   onTap:(){
                            //     print("{object}");
                            //   },
                            //   child: Container(height: 100, width: double.infinity, child: Center(child: Row(
                            //     children: [
                            //       SizedBox(width: 20,),
                            //       GlowIcon(
                            //         Icons.add_card,
                            //         color: Colors.blue,
                            //         glowColor: Colors.blue,
                            //         size: 64,
                            //         blurRadius: 9,
                            //       ),
                            //       SizedBox(width: 30,),
                            //       Text("Request Plastic card",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                            //     ],
                            //   )),).asGlass(
                            //     tintColor: Colors.transparent,
                            //       clipBorderRadius: BorderRadius.circular(15)
                            //   ),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap:(){
                                print("{object}");
                              },
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                child: Center(child: Row(
                                  children: [
                                    SizedBox(width: 20,),
                                    GlowIcon(
                                      Icons.delete,
                                      color: Colors.red,
                                      glowColor: Colors.red,
                                      size: 64,
                                      blurRadius: 9,
                                    ),
                                    SizedBox(width: 30,),
                                    Text("Disable Plastic Card",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                                  ],
                                )),
                              ).asGlass(
                                tintColor: Colors.transparent,
                                  clipBorderRadius: BorderRadius.circular(15)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      ),
    );
  }
}
