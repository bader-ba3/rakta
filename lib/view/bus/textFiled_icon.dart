import 'package:flutter/material.dart';

import '../../utils/app_layout.dart';
import '../../utils/app_style.dart';

class TextFiledIcon extends StatelessWidget {
  const TextFiledIcon({
    super.key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.listItem,
  });

  final String text;
  final IconData icon;
  final TextEditingController controller;
  final List<String> listItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppLayout.getWidth(15),
            vertical: AppLayout.getHeight(0)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Autocomplete<String>(
          fieldViewBuilder:
              (context, textEditingController, focusNode, onFieldSubmitted) =>
                  TextFormField(

            focusNode: focusNode,
            controller: textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              label: Text(text,style: Styles.headLineStyle2,),
              hintText: "Select the station",
              floatingLabelAlignment: FloatingLabelAlignment.start,
              floatingLabelBehavior:FloatingLabelBehavior.always ,
    /*          icon: Icon(
                icon,
                color: Styles.orangeColor,
              ),*/
              // hintText: text,
            ),
            maxLines: 1,
            cursorHeight: 25,
            clipBehavior: Clip.none,
            style: Styles.headLineStyle3,

          ),
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return listItem.where((element) => element
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          onSelected: (c) {
            controller.text = c;
          },
        ));
  }
}
