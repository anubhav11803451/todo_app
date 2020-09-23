import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController todoController;
  const AddTodo({Key key, this.todoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.only(top: 30, bottom: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: TextFormField(
        controller: todoController,
        // initialValue: intialValue,
        // onChanged: onChanged,
        expands: true,
        maxLines: null,
        enableInteractiveSelection: true,
        cursorColor: Colors.deepPurple[200],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "What's your plan?",
          hintStyle: GoogleFonts.montserrat(
            fontSize: 15,
          ),
        ),
        style: GoogleFonts.montserratAlternates(fontSize: 18),
      ),
    );
  }
}
