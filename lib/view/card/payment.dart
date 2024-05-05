import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/payment_controller.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int? selected ;
  TextEditingController textEditingController= TextEditingController();
  @override
  void initState() {
    Stripe.instance.isApplePaySupported.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    Stripe.instance.isApplePaySupported.removeListener(update);
    super.dispose();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List a =[5,10,20,40,50,100,200];
    return Scaffold(
      appBar: AppBar(centerTitle: true,title: Text("Add Balance"),),
      body: GetBuilder<PaymentController>(
        builder: (controller) {
          return SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 4),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black),borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(border: InputBorder.none,hintText: "Enter Balance"),
                            onChanged: (_){
                              selected=null;
                              setState(() {

                              });
                            },
                          ),
                        ),
                        Text("AED",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                        SizedBox(width: 10,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0,),
                for(var i in a)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 4),
                    child: InkWell(
                      onTap: (){
                        selected = i;
                        textEditingController.clear();
                        setState(() {});
                      },
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.black),color:selected ==i ?Colors.blueAccent:Colors.grey.shade200),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Center(child: Text(i.toString()+" AED",style: TextStyle(fontWeight: selected ==i ?FontWeight.bold:FontWeight.normal,color: selected ==i ?Colors.white:Colors.black),)),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 200,
                    decoration: BoxDecoration(color: Colors.blue.shade800,borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text("Special offer",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 25),),
                        Text("get 10% balance if you charge your card with more than 100 AED on April",style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ApplePayButton(
                     type: ApplePayButtonType.addMoney,
                      onPressed: selected!=null||textEditingController.text.isNotEmpty?() async {
                        bool _ = await controller.handleApplePayPress(context,(selected??int.parse(textEditingController.text)).toDouble());
                        if(_){
                          controller.addBalance((selected??int.parse(textEditingController.text)).toDouble());
                        }
                      }:null,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
