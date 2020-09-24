import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTodo extends StatelessWidget {
  final TextEditingController todoContentController;
  final TextEditingController todoTitleController;
  const AddTodo({Key key, this.todoContentController, this.todoTitleController})
      : super(key: key);

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
      child: Column(
        children: [
          TextFormField(
            controller: todoTitleController,
            cursorColor: Colors.deepPurple[200],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurple[100], width: 2.0)),
              hintText: "Title",
              hintStyle: GoogleFonts.montserrat(
                fontSize: 18,
              ),
            ),
            style: GoogleFonts.montserratAlternates(fontSize: 18),
          ),
          Expanded(
            child: Container(
              height: 500,
              child: TextFormField(
                controller: todoContentController,
                expands: true,
                maxLines: null,
                // minLines: null,
                enableInteractiveSelection: true,
                cursorColor: Colors.deepPurple[200],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "What's on your list today?",
                  hintStyle: GoogleFonts.montserrat(
                    fontSize: 14,
                  ),
                ),
                style: GoogleFonts.montserrat(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
