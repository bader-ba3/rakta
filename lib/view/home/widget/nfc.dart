import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class NFC extends StatelessWidget {
  const NFC({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: [
              Lottie.asset('assets/nfc.json',width: 400),
              Expanded(
                child: Hero(
                  tag: "nfc",
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset("assets/saqr.png")),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}
