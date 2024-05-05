import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/app_style.dart';
import 'app_bottom.dart';


class BusPage extends StatefulWidget {
  const BusPage({super.key});

  @override
  State<BusPage> createState() => _BusPageState();
}

class _BusPageState extends State<BusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        toolbarHeight: 80,
        title: Container(
          color: primary,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Image.asset(
            "assets/logo-wide.png",
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Text(
                      "07:00 AM ",
                      style: Styles.headLineStyle3,
                    ),
                    const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    const Icon(
                      CupertinoIcons.clock,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "2h 15min ",
                      style: Styles.headLineStyle3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Text(
                      "30 AED ",
                      style: Styles.headLineStyle3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Divider(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                CupertinoIcons.sun_max,
                color: Colors.yellow.shade900,
                size: 18,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                "At this trip, sun will shine mostly from left side",
                style: Styles.headLineStyle3.copyWith(fontSize: 14),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        color: Colors.pink.shade100,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Woman",
                    style: Styles.headLineStyle3,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        color: primary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Man",
                    style: Styles.headLineStyle3,
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Available",
                    style: Styles.headLineStyle3,
                  )
                ],
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index<9? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SeatWidget(
                            index: index,
                            columnIndex: 1,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SeatWidget(
                            index: index,
                            columnIndex: 2,
                          ),
                          const Spacer(),
                          SeatWidget(
                            index: index,
                            columnIndex: 3,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          SeatWidget(
                            index: index,
                            columnIndex: 4,
                          ),
                        ],
                      ):
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SeatWidget(
                              index: 9,
                              columnIndex: 1,
                            ),
                            SeatWidget(
                              index: 9,
                              columnIndex: 2,
                            ),
                            SeatWidget(
                              index: 9,
                              columnIndex: 3,
                            ),
                            SeatWidget(
                              index: 9,
                              columnIndex: 4,
                            ),
                            SeatWidget(
                              index: 9,
                              columnIndex: 5,
                            ),
                          ],
                        );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: 10),

              ],
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AppBottom(onTap: (){
            picked.addAll(listSelected);
            listSelected.clear();
            setState(() {

            });

          },text: "Confirm",),
        ),
      ),
    );
  }
}
List<int> picked = [
  1,
  2,
  5,
  11,
  13,
  14,
  16,
  17,
  18,
  19,
  20,
  22,
  25,
  26,
  27,
  29,
  33,
  34,
  40,
  41,
];
List<int> listSelected = [];
class SeatWidget extends StatefulWidget {
  const SeatWidget({super.key, required this.index, required this.columnIndex});

  @override
  State<SeatWidget> createState() => _SeatWidgetState();
  final int index, columnIndex;
}

class _SeatWidgetState extends State<SeatWidget> {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!picked.contains((widget.index * 4) + widget.columnIndex)) {
          if (!listSelected.contains((widget.index * 4) + widget.columnIndex)) {
            listSelected.add((widget.index * 4) + widget.columnIndex);
          } else {
            listSelected.remove((widget.index * 4) + widget.columnIndex);
          }
        } else {
          Fluttertoast.showToast(msg: "هذا المقعد محجوز من قبل");
        }
        setState(() {});
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: Durations.short4,
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.2)),
                color: listSelected
                        .contains((widget.index * 4) + widget.columnIndex)
                    ? Colors.greenAccent.shade700
                    : widget.index < 5
                        ? picked.contains(
                                (widget.index * 4) + widget.columnIndex)
                            ? Colors.pink.shade100
                            : Colors.transparent
                        : picked.contains(
                                (widget.index * 4) + widget.columnIndex)
                            ? primary.withOpacity(0.5)
                            : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: Text(
              "${(widget.index * 4) + widget.columnIndex}",
              style: Styles.headLineStyle3.copyWith(color: Colors.black),
            )),
          ),
          Positioned(
            top: -8,
            right: -8,
            child: AnimatedCrossFade(
                firstChild: Container(
                    padding: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.greenAccent,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )),
                secondChild: const SizedBox(),
                crossFadeState: listSelected
                        .contains((widget.index * 4) + widget.columnIndex)
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Durations.short4),
          ),
        ],
      ),
    );
  }
}
