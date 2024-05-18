import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:rakta/controller/main_view_model.dart';
import 'package:rakta/utils/hive.dart';
import 'package:rakta/view/card/payment.dart';
import 'package:rakta/view/home/news_details.dart';
import 'package:rakta/view/home/widget/hero_dialog_route.dart';
import '../bus/bus_home.dart';
import 'widget/nfc.dart';

class Home extends StatelessWidget {
  Home({super.key});
  List a = [
    Color(0xFFffbc42),
    Color(0xFFd81159),
    Color(0xFF218380),
    Color(0xFF73d2de),
    Color(0xFF014f86),
    const Color(0xFF8f2d56),
  ];

  @override
  Widget build(BuildContext context) {
    var radiusBackCircle = MediaQuery.sizeOf(context).width / 1.2;
    List<({String title,String body})>cardInfo= [
      (title: "RAKTA meets with its strategic partners",body:"Ras Al Khaimah Transport Authority (RAKTA) held its first meeting with its strategic partners from various economic and service sectors, which operate in partnership with RAKTA and contribute to providing services to the public from various segments of society. The meeting aimed to expand communication between RAKTA and its partners to strengthen and enhance the bonds of mutual cooperation and emphasize collective work to achieve joint initiatives and projects to contribute to achieving the directives of the wise government in the public interest and enhancing the services provided to the public.", ),
      (title: "Sheikh Khaled Al Qasimi Inaugurates New Building",body: "Sheikh Khalid bin Saud Al Qasimi, Vice Chairman of Ras Al Khaimah’s Investment and Development Office, inaugurated a new facility for Ras Al Khaimah Transport Authority (RAKTA), praising the entity’s accomplishments and pivotal role in enhancing the Emirate’s transport network. The new facility aligns with the vision of His Highness Sheikh Saud bin Saqr Al Qasimi, UAE Supreme Council Member and Ruler of Ras Al Khaimah, to embrace advanced technologies and use them to upgrade the services that the Emirate offers to its residents and visitors, and further strengthen its global standing across various sectors."),
      (title: "RAKTA Launches “RAK Ride”",body: "As part of its efforts to provide integrated and sustainable transportation solutions that facilitate the movement of residents, visitors, and tourists to meet the needs of all community segments, RAKTA has launched the “RAK Ride” express bus service. This service offers direct, non-stop transportation on main operational lines with multiple routes connecting various areas within the emirate, particularly industrial areas to the city center, ensuring fast and efficient transport from the first mile to the last, enabling users to reach their destinations swiftly, comfortably, and safely."),
    ];
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Image.asset("assets/background-home.png",fit:BoxFit.fitWidth ,width: MediaQuery.sizeOf(context).width,),
          // Container(height: MediaQuery.sizeOf(context).height,width: MediaQuery.sizeOf(context).width,color: Colors.white38,),
          SizedBox(
            height: 400,
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                      left: -160,
                      top: 60,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue.shade300.withOpacity(0.7),
                        radius: 150,
                        child: CircleAvatar(
                          radius: 120,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.blue.withOpacity(0.7),
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Stack(
              children: [
                Positioned(
                    right: -radiusBackCircle,
                    bottom: -radiusBackCircle,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade300.withOpacity(0.7),
                      radius: radiusBackCircle,
                      child: CircleAvatar(
                        radius: radiusBackCircle - 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: radiusBackCircle - 100,
                          backgroundColor: Colors.amber.withOpacity(0.7),
                          child: CircleAvatar(
                            radius: radiusBackCircle - 150,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 8,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width-80,
                                child: Text(
                                  "Hello "+HiveDataBase.getUserData().name,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
                                ),
                              ),
                              // Container(
                              //   height: 40,
                              //   width: 40,
                              //   padding: EdgeInsets.all(5),
                              //   decoration: BoxDecoration(color: Colors.white, border: Border.all(), borderRadius: BorderRadius.circular(100)),
                              //   child: Image.asset(color: Colors.amber.shade800, "assets/Bell.png"),
                              // ),
                              GlowContainer(
                                height: 40,
                                width: 40,
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(width: 2),
                                // decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2), borderRadius: BorderRadius.circular(100)),
                                child: GlowIcon(
                                  Icons.notifications_none,
                                  color: Colors.amber.shade800,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, HeroDialogRoute(builder: (context) => NFC()));
                        },
                        child: Material(
                          color: Colors.transparent,
                          child: Hero(
                            tag: "nfc",
                            child: RotatedBox(
                              quarterTurns: 0,
                              child: SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(borderRadius: BorderRadius.circular(15), child: Image.asset("assets/saqr.png")),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text("User Favorite", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                            SizedBox(
                              width: 10,
                            ),
                            GlowContainer(
                          height: 35,
                          width: 35,
                          color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 2),
                          // decoration: BoxDecoration(color: Colors.white, border: Border.all(width: 2), borderRadius: BorderRadius.circular(100)),
                          child: GlowIcon(
                            Icons.add,
                            color: Colors.amber.shade800,
                            size: 27,
                          ),
                        ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 3.3,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 4,
                          itemBuilder: (context, index) => boxWidget(context, index),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 3.5,
                    width: MediaQuery.sizeOf(context).width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Our News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                        ),
                        // Expanded(
                        //   child: PageFlipWidget(
                        //     key: _controller,
                        //     cutoffForward: 100,
                        //     cutoffPrevious: 100,
                        //     backgroundColor: Colors.white,
                        //     // isRightSwipe: true,
                        //     lastPage: Container(color: Colors.transparent, child: const Center(child: Text('Last Page!'))),
                        //     children: List.generate(5, (index) => Container(
                        //       decoration: BoxDecoration(color: Colors.white,border: Border.all(),borderRadius: BorderRadius.circular(8)),
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: InkWell(
                        //           onTap: (){
                        //             Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(id: index.toString(),),));
                        //           },
                        //           child: Stack(
                        //             children: [
                        //               Row(
                        //                 children: [
                        //                   Expanded(
                        //                     child: Hero(
                        //                       tag: "news_image_hero_"+index.toString(),
                        //                       child: Material(
                        //                         child: AspectRatio(
                        //                           aspectRatio: 1,
                        //                           child: Placeholder(),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     flex: 2,
                        //                     child: Padding(
                        //                       padding: const EdgeInsets.all(8.0),
                        //                       child: Column(
                        //                         crossAxisAlignment: CrossAxisAlignment.start,
                        //                         children: [
                        //                           Hero(
                        //                               tag:"news_title_hero_"+index.toString(),
                        //                               child: Material(child: Text("Title Title",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),))),
                        //                           Text("body "*20),
                        //                         ],
                        //                       ),
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //              Align(
                        //                alignment: Alignment.bottomRight,
                        //                child: Container(
                        //                color: Colors.white,
                        //                child: Text("Flip The Page ->"),),
                        //              )
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     )),
                        //   ),
                        // ),
                        Center(
                          child: SizedBox(
                            height: 200,
                            child: AspectRatio(
                              aspectRatio: 16/9 ,
                              child: CardSwiper(
                                padding: EdgeInsets.zero,
                                cardsCount: cardInfo.length,
                                cardBuilder: (context, index, percentThresholdX, percentThresholdY) => Stack(
                                  children: [
                                    Hero(
                                      tag: "news_background_hero_" + index.toString(),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          height: 230,
                                          width: MediaQuery.sizeOf(context).width,
                                         decoration:BoxDecoration(
                                           borderRadius: BorderRadius.circular(15),
                                           color: Colors.white,)
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag: "news_image_hero_" + index.toString(),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          height: 230,
                                          width: MediaQuery.sizeOf(context).width,
                                          foregroundDecoration: BoxDecoration(borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                            Colors.black54,
                                                Colors.black45,
                                                Colors.black45,
                                            Colors.transparent

                                          ])),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              image: DecorationImage(image: AssetImage("assets/rak$index.jpg"),fit: BoxFit.cover)),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            fullscreenDialog: true,
                                            transitionDuration: Duration(milliseconds: 500),
                                            pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                                              return NewsDetails(
                                                id: index.toString(),
                                                data :cardInfo[index],
                                              );
                                            },
                                            transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                              return FadeTransition(
                                                opacity: animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
                                                child: child,
                                              );
                                            },
                                          ),
                                        );

                                        // Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetails(id: index.toString(),),));
                                      },
                                      child: Container(
                                          height: 230,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15),
                                              color: Colors.transparent, border: Border.all()),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Hero(
                                                    tag: "news_title_hero_" + index.toString(),
                                                    child: Material(
                                                        color: Colors.transparent,
                                                        child: Text(
                                                          cardInfo[index].title,
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                                                        ))),
                                                Hero(
                                                    tag: "news_body_hero_" + index.toString(),
                                                    child: Material(
                                                        color: Colors.transparent,
                                                        child: Text(
                                                          cardInfo[index].body,
                                                          maxLines: 4,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(fontSize: 16, color: Colors.white),
                                                          textAlign: TextAlign.center,
                                                        ))),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget boxWidget(context, index) {
    List favItems = ["My Card","Book Bus","Profile","Add Balance"];
    List onTap = [
      (){
      MainViewModel mainController = Get.find<MainViewModel>();
      mainController.pageController.jumpToPage(3);
      mainController.updateIndex(3);
      },
      (){Get.to(()=>BusHomeScreen());},
      (){
        MainViewModel mainController = Get.find<MainViewModel>();
        mainController.pageController.jumpToPage(4);
        mainController.updateIndex(4);
      },
      (){Get.to(()=>PaymentScreen());},
    ];
    List favIconItems = [Icons.rectangle_outlined,Icons.directions_bus_filled,Icons.person,Icons.add];
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: onTap[index],
        child: Container(
          height: MediaQuery.sizeOf(context).width / 3.3,
          width: MediaQuery.sizeOf(context).width / 3.3,
          decoration: BoxDecoration(color: (a[4] as Color), borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.black)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white60,
                child: Center(
                    child: Icon(
                      favIconItems[index],
                  color: Colors.white,
                  size: 40,
                )),
              ),
              Text(
                favItems[index],
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
