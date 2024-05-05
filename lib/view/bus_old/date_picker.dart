import 'package:flutter/material.dart';

import '../../utils/app_style.dart';

// ignore: must_be_immutable
class DatePicker extends StatelessWidget {
  DatePicker({super.key, required this.text, required this.controller});

  final String text;

  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    void showDatePickers() {
      showDatePicker(
        // barrierColor: primary,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      ).then((value) {
        controller.text = "${value?.day} April Sandy";
      });
    }

    return GestureDetector(
      onTap: () {
        showDatePickers();
      },
      child: Center(
        child: TextFormField(
          controller: controller,
          enabled: false,
          decoration: InputDecoration(
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Styles.primaryColor)),
              label: Text(text),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: Styles.textStyle,
              suffixIcon: Icon(
                Icons.date_range,
                // color: Styles.blueColor,
              ),
              // suffixIcon: Icon(Icons.arrow_drop_down,color: Colors.black,),
              hintText:
                  "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
          maxLines: 1,
          cursorHeight: 25,
          clipBehavior: Clip.none,
          style: Styles.headLineStyle3,
        ),
      ),
    );
  }
}
