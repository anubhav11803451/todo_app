import 'package:flutter/material.dart';

class Inputbox extends StatelessWidget {
  final double height, width;
  final String hintText;
  final Color boxColor, cursorColor;
  final TextStyle hintStyle;
  final Icon icon;
  final Widget suffixIcon;
  final bool obscure;
  final TextEditingController controller;
  final void Function(String value) validator;
  const Inputbox({
    Key key,
    this.height,
    this.width,
    this.hintText,
    this.boxColor,
    this.hintStyle,
    this.icon,
    this.obscure = false,
    this.suffixIcon,
    this.controller,
    this.cursorColor = Colors.white38,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: boxColor,
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        cursorColor: cursorColor,
        decoration: InputDecoration(
          icon: icon,
          suffixIcon: suffixIcon,
          hoverColor: Colors.white,
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }
}
