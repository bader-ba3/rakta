import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewsDetails extends StatelessWidget {
  final String id ;
  final ({String body, String title}) data;
  const NewsDetails({super.key, required this.id, required  this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(),
      body: Stack(
        children: [
          Hero(
            tag: "news_background_hero_"+id,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                color: Colors.white,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Row(
                  children: [
                    BackButton(),
                  ],
                ),
                Hero(
                  tag: "news_image_hero_"+id.toString(),
                  child: SizedBox(
                    height: 220,
                    width: 100,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        AspectRatio(
                          aspectRatio: 16/9 ,
                          child: Center(
                            child: Container(
                              height: 230,
                              width: MediaQuery.sizeOf(context).width,
                              foregroundDecoration: BoxDecoration(   borderRadius: BorderRadius.circular(15),gradient: LinearGradient(
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
                                  image: DecorationImage(image: AssetImage("assets/rak$id.jpg"),fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Hero(
                       tag:"news_title_hero_"+id.toString(),child: Material( color: Colors.transparent,child: Text(data.title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),))),
                 ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                      tag:"news_body_hero_"+id.toString(),child: Material(
                      color: Colors.transparent,
                      child: Text(data.body,style: TextStyle(fontSize: 18),))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
