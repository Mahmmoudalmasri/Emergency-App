import 'package:flutter/material.dart';

class Constants {
  static const Color greyColor = Color(0xFFF4F4F4);
  static const Color redColor = Color(0xFFE00508);
  static const Color orangeColor = Color(0xFFFD4C00);
  static const Color blueColor = Color(0xFF0773DC);
  static const Color darkBlueColor = Color(0xFF044686);

  static ButtonStyle redButtonStyles(double vertPadding, double horizPadding) {
    return ElevatedButton.styleFrom(
      backgroundColor: Constants.redColor,
      elevation: 2,
      padding:
          EdgeInsets.symmetric(vertical: vertPadding, horizontal: horizPadding),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
    );
  }

  static Widget label(
      String text, double size, double vertPadding, double horzPadding) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: vertPadding * 0.01, horizontal: horzPadding * 0.03),
          child: Text(
            text,
            style: TextStyle(
                color: Constants.darkBlueColor,
                fontSize: size * 0.04,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  static InputDecoration fieldsDecoration(String hint) {
    return InputDecoration(
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.white);
  }
}
