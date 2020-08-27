import 'package:flutter/material.dart';

class Inputbox extends StatelessWidget {
  final double height, width;
  final String hintText;
  final Color boxColor;
  final TextStyle hintStyle;
  final Icon icon;
  final Widget suffixIcon;
  final bool obscure;
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
      child: TextField(
        obscureText: obscure,
        cursorColor: Colors.white38,
        decoration: InputDecoration(
          icon: icon,
          suffixIcon: suffixIcon,
          hoverColor: Colors.white,
          hintText: hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
