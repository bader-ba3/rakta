import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:appcheck/appcheck.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/home/home_page.dart';
import 'package:uae_pass_flutter/uae_pass.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  String? data;
  String redirectLink = "ba3://com.ba3.uaepass";
  StreamSubscription? _sub;
  late UaePass uaePassPlugin = UaePass();

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
    uaePassPlugin = UaePass();
    uaePassPlugin.setUpEnvironment("sandbox_stage", "sandbox_stage", "ba3","a",redirectUri: redirectLink);

  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
  getData(code){
    if(code!=null) {
      http.post(Uri.parse("https://stg-id.uaepass.ae/idshub/token?grant_type=authorization_code&redirect_uri=${redirectLink}&code="+code!),headers: {
        "Authorization":"Basic c2FuZGJveF9zdGFnZTpzYW5kYm94X3N0YWdl",
        "Content-Type":"multipart/form-data"
      }).then((value) {
        String access_token = json.decode( value.body)['access_token'];

        http.get(Uri.parse("https://stg-id.uaepass.ae/idshub/userinfo"),headers: {
          "Authorization":"Bearer "+access_token
        }).then((value) async {
          print("hello 1");
          print(value.body);
          var name = json.decode(value.body)['firstnameEN']+" "+json.decode(value.body)['lastnameEN'];
          var gender = json.decode(value.body)['gender'];
          var mobile = json.decode(value.body)['mobile'];
          var email = json.decode(value.body)['email'];
          await HiveDataBase.setUserData((name: name,email: email,gender: gender,mobile: mobile));


          // data = value.body.toString();
          Get.offAll(()=>HomePage());
          // setState(() {});
        });
      });
    }
  }

  void _handleIncomingLinks() {

    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        if(uri!=null) {
          getData(uri.queryParameters["code"]);
        }
      });
    }
  }


  Future<void> _handleInitialUri() async {
    final uri = await getInitialUri();
    if (!mounted) return;
    if(uri!=null) {
      getData(uri.queryParameters["code"]);
    }
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: AppCheck.checkAvailability(Platform.isIOS?"uaepassstg://":"ae.uaepass.mainapp.stg"), builder: (context, snapshot) {
      if(snapshot.data==null){
        return   InkWell(onTap: (){
          launchUrl(Uri.parse(
              "https://stg-id.uaepass.ae/idshub/authorize?redirect_uri=${redirectLink}&client_id=sandbox_stage&response_type=code&state=a&scope=urn:uae:digitalid:profile:general urn:uae:digitalid:profile:general:profileType urn:uae:digitalid:profile:general:unifiedId&acr_values=urn:safelayer:tws:policies:authentication:level:low"
          ),mode:
          Platform.isIOS
              ?LaunchMode.externalApplication
              :LaunchMode.platformDefault
          );
        }, child: Container(
          height: 80,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ], borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
          child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w400, fontSize: 30),
                  ),
                  Image.asset(
                    "assets/UAEPASS.png",
                    width: 40,
                  )
                ],
              )),
        ),);
      }else{
        return Column(
          children: [
            InkWell(onTap: () async {
              String token = await uaePassPlugin.signIn();
              if(Platform.isIOS){
                String accessToken = await uaePassPlugin.getAccessToken(token);
                http.get(Uri.parse("https://stg-id.uaepass.ae/idshub/userinfo"),headers: {
                  "Authorization":"Bearer $accessToken"
                }).then((value) async {
                  print("hello 2");
                  var name = json.decode(value.body)['firstnameEN']+" "+json.decode(value.body)['lastnameEN'];
                  var gender = json.decode(value.body)['gender'];
                  var mobile = json.decode(value.body)['mobile'];
                  var email = json.decode(value.body)['email'];
                  await HiveDataBase.setUserData((name: name,email: email,gender: gender,mobile: mobile));
                  Get.offAll(()=>HomePage());
                  // data = value.body.toString();
                  // setState(() {});
                });
              }else{
                getData(token);
              }

            }, child: Container(
              height: 80,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                )
              ], borderRadius: BorderRadius.circular(8), color: Colors.white, border: Border.all(color: Colors.black, width: 2)),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.w400, fontSize: 30),
                      ),
                      Image.asset(
                        "assets/UAEPASS.png",
                        width: 40,
                      )
                    ],
                  )),
            ),),
          ],
        );
      }
    },);
    // return MaterialApp(
    //   home: SafeArea(
    //     child: Scaffold(
    //         body:SizedBox(
    //           width: double.infinity,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               // alsjdnkj
    //               // jghtjhgicvbv
    //               //check uaepass application is existing on the user device
    //               //note: you must add
    //
    //               // <queries>
    //               // <package android:name="ae.uaepass.mainapp.stg"/>
    //               // <package android:name="ae.uaepass.mainapp" />
    //               // </queries>
    //
    //               // to main/androidManifest.xml file
    //               // Text("sigin using web"),
    //
    //               // FutureBuilder(future: AppCheck.checkAvailability("ae.uaepass.mainapp.stg"), builder: (context, snapshot) {
    //
    //
    //               // SizedBox(height: 50,),
    //               //
    //               // ElevatedButton(onPressed: (){
    //               //   launchUrl(Uri.parse("https://stg-id.uaepass.ae/idshub/logout"));
    //               // }, child: Text("logout")),
    //               // if(data!=null)
    //               //   Text(data.toString())
    //             ],
    //           ),
    //         )
    //     ),
    //   ),
    // );
  }
}