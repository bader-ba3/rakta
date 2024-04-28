import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rakta/view/onboarding/onboarding.dart';

import '../../utils/hive.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xfff3f2f5),
      appBar: AppBar(
        backgroundColor: Color(0xfff3f2f5),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: (){
                HiveDataBase.deleteUserData();
                Get.offAll(()=>OnBoardingView());
              },
              child: Icon(Icons.logout)),
          SizedBox(width: 20,)
        ],
        title: Text("Personal Info"),
      ),
      body:Column(
        children: [
          Expanded(flex: 1,child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color(0xfff3f2f5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Hero(
                tag: "profile_image",
                child: Material(
                  color: Colors.transparent,
                  child:  Container(
                    width: 100,
                    height:100,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/profile.png"),fit: BoxFit.fitWidth),color: Colors.grey.shade300,borderRadius: BorderRadius.circular(100),boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(1, 1),blurRadius: 20)]),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Hero(
                  tag: "profile_name",
                  child: Material(
                      color: Colors.transparent,
                      child: Text(HiveDataBase.getUserData().name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),))),

            ],),
          ),),
          Expanded(flex: 2,child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.horizontal(right: Radius.circular(30),left: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text("Email: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                      Text(HiveDataBase.getUserData().email,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Phone: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                      Text(HiveDataBase.getUserData().mobile,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Gender: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                      Text(HiveDataBase.getUserData().gender,style: TextStyle(fontSize: 18),),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width/1.5,
                      decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.edit,),
                            SizedBox(width: 5,),
                            Text("Update Account",),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width/1.5,
                      decoration: BoxDecoration(border: Border.all(color: Colors.red.shade800,),borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete,color: Colors.red,),
                            SizedBox(width: 5,),
                            Text("Delete Account",style: TextStyle(color: Colors.red.shade800),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),),
        ],
      ) ,
    );
  }
}
