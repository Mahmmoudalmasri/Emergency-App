import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  String textfeild;

  textField(this.textfeild);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            hintText: textfeild,
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }
}
