import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BusSeatWidget extends StatefulWidget {
  final Null Function(List<int> seats) onChooseSeat;
  final int persons;
  const BusSeatWidget({super.key, required  this.onChooseSeat,required this.persons});

  @override
  State<BusSeatWidget> createState() => _BusSeatWidgetState();
}
class _BusSeatWidgetState extends State<BusSeatWidget> {
  List<int>  picked = [];
  List<int> listSelected = [];

  @override
  void initState() {

  picked=generateRandomNumbers(widget.persons);

    super.initState();

  }
  List<int> generateRandomNumbers(int count) {
    List<int> numbers = [];
    while (numbers.length < count) {
      int num = Random().nextInt(47) + 1;
      if (!numbers.contains(num)) {
        numbers.add(num);
      }
    }
    return numbers;
  }
  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/top.png",
          // height: MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).height/3
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.fill,
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            // height: MediaQuery.sizeOf(context).height - MediaQuery.sizeOf(context).height/3,
            width: MediaQuery.sizeOf(context).width,
            child: AspectRatio(
              aspectRatio: 1/3,
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.red.withOpacity(0.0),
                child: Column(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: List.generate(12, (index) => (index + 1) + (index * 3))
                                    .map((index) => Expanded(
                                    child: InkWell(
                                      onTap: picked.contains(index)
                                          ? null
                                          : () {
                                        setState(() {
                                          if (listSelected.contains(index)) {
                                            listSelected.remove(index);
                                          } else {
                                            listSelected.add(index);
                                          }
                                          widget.onChooseSeat(listSelected);
                                        });
                                      },
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SvgPicture.asset(listSelected.contains(index)
                                                      ? "assets/images/green.svg"
                                                      : picked.contains(index)
                                                      ? "assets/images/blue.svg"
                                                      : "assets/images/white.svg",width: MediaQuery.sizeOf(context).width/3),
                                                  Text(index.toString())
                                                ],
                                              ))),
                                    )))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: List.generate(12, (index) => (index + 2) + (index * 3))
                                    .map((index) => Expanded(
                                    child: InkWell(
                                      onTap: picked.contains(index)
                                          ? null
                                          : () {
                                        setState(() {
                                          if (listSelected.contains(index)) {
                                            listSelected.remove(index);
                                          } else {
                                            listSelected.add(index);
                                          }
                                          widget.onChooseSeat(listSelected);
                                        });
                                      },
                                      child: Container(
                                          color: Colors.transparent,
                                          child: Center(
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  SvgPicture.asset(listSelected.contains(index)
                                                      ? "assets/images/green.svg"
                                                      : picked.contains(index)
                                                      ? "assets/images/blue.svg"
                                                      : "assets/images/white.svg",width: MediaQuery.sizeOf(context).width/3,),
                                                  Text(index.toString())
                                                ],
                                              ))),
                                    )))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Column(
                                children: [
                                  Spacer(
                                    flex: 11,
                                  ),
                                  Expanded(
                                      child: InkWell(
                                        onTap: picked.contains(47)
                                            ? null
                                            : () {
                                          setState(() {
                                            if (listSelected.contains(47)) {
                                              listSelected.remove(47);
                                            } else {
                                              listSelected.add(47);
                                            }
                                            widget.onChooseSeat(listSelected);
                                          });
                                        },
                                        child: Container(
                                            color: Colors.transparent,
                                            child: Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(listSelected.contains(47)
                                                        ? "assets/images/green.svg"
                                                        : picked.contains(47)
                                                        ? "assets/images/blue.svg"
                                                        : "assets/images/white.svg",width: MediaQuery.sizeOf(context).width/3,),
                                                    Text("47")
                                                  ],
                                                ))),
                                      ))
                                ],
                              )),

                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: List.generate(12, (index) => (index + 3) + (index * 3))
                                    .map((e) => Expanded(
                                    child: e == 23
                                        ? SizedBox()
                                        : Builder(builder: (context) {
                                      int index = e > 23 ? e - 4 : e;
                                      return InkWell(
                                        onTap: picked.contains(index)
                                            ? null
                                            : () {
                                          setState(() {
                                            if (listSelected.contains(index)) {
                                              listSelected.remove(index);
                                            } else {
                                              listSelected.add(index);
                                            }
                                            widget.onChooseSeat(listSelected);
                                          });
                                        },
                                        child: Container(
                                            color: Colors.transparent,
                                            child: Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(listSelected.contains(index)
                                                        ? "assets/images/green.svg"
                                                        : picked.contains(index)
                                                        ? "assets/images/blue.svg"
                                                        : "assets/images/white.svg",width: MediaQuery.sizeOf(context).width/3,),
                                                    Text(index.toString())
                                                  ],
                                                ))),
                                      );
                                    })))
                                    .toList(),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.transparent,
                              child: Column(
                                children: List.generate(12, (index) => (index + 4) + (index * 3))
                                    .map((e) => Expanded(
                                    child: e == 24
                                        ? SizedBox()
                                        : Builder(builder: (context) {
                                      int index = e > 24 ? e - 4 : e;
                                      return InkWell(
                                        onTap: picked.contains(index)
                                            ? null
                                            : () {
                                          setState(() {
                                            if (listSelected.contains(index)) {
                                              listSelected.remove(index);
                                            } else {
                                              listSelected.add(index);
                                            }
                                            widget.onChooseSeat(listSelected);
                                          });
                                        },
                                        child: Container(
                                            color: Colors.transparent,
                                            child: Center(
                                                child: Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    SvgPicture.asset(listSelected.contains(index)
                                                        ? "assets/images/green.svg"
                                                        : picked.contains(index)
                                                        ? "assets/images/blue.svg"
                                                        : "assets/images/white.svg",width: MediaQuery.sizeOf(context).width/3,),
                                                    Text(index.toString())
                                                  ],
                                                ))),
                                      );
                                    })))
                                    .toList(),
                              ),
                            ),
                          ),




                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

