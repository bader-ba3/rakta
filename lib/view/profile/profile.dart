import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/profile/personal_info.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20,),
                Hero(
                  tag: "profile_image",
                  child: Material(
                    color: Colors.transparent,
                    child:  Container(
                      width: 60,
                      height:60,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/profile.png"),fit: BoxFit.fitWidth),color: Colors.grey.shade300,borderRadius: BorderRadius.circular(100),boxShadow: [BoxShadow(color: Colors.black45,offset: Offset(1, 1),blurRadius: 20)]),
                    ),
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                        tag: "profile_name",
                        child: Material(
                            color: Colors.transparent,
                            child: Text(HiveDataBase.getUserData().name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),))),
                    Text(HiveDataBase.getUserData().mobile,style: TextStyle(fontWeight:FontWeight.w300,color: Colors.grey.shade800 ),)
                  ],
                )
              ],
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 22.0),
              child: Row(
                children: [
                  Text("General",style: TextStyle(color:  Colors.grey),),
                  SizedBox(width: 10,),
                  Expanded(child: Container(height: 2,color: Colors.grey.shade300,))
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: ()=>Get.to(PersonalInfo()),
                      child: item("Personal info","assets/User.png")),
                  item("Payment methods","assets/wallet.png"),
                  item("Dark mode","assets/Eye.png"),
                  item("Language","assets/Document.png"),
                  item("Help center","assets/Info square.png"),
                  item("Privacy policy","assets/Lock.png"),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 22.0),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Image.asset("assets/Home.png",color: Colors.red,width: 30,),
                        SizedBox(width: 15,),
                        Text("Logout",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.red),),
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  Widget item(text,path){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 10,),
          SizedBox(
            height: 30,
              width: 30,
              child: Image.asset(path,color: Colors.black,)),
          SizedBox(width: 15,),
          Text(text,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          Spacer(),
          Icon(Icons.arrow_forward_ios_sharp)
        ],
      ),
    );
  }
}
