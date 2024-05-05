import 'package:flutter/material.dart';

import '../../utils/app_style.dart';

class AppBottom extends StatelessWidget {
  const AppBottom({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
         color: Color(0xFF014f86),
        ),
        child: Center(
          child: Text(
            text,
            style: Styles.headLineStyle2.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
