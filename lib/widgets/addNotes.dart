import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotes extends StatelessWidget {
  final TextEditingController notesController;
  const AddNotes({Key key, this.notesController}) : super(key: key);

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
        controller: notesController,
        expands: true,
        maxLines: null,
        enableInteractiveSelection: true,
        cursorColor: Colors.deepPurple[200],
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "What's on your beautiful mind?",
          hintStyle: GoogleFonts.montserrat(
            fontSize: 15,
          ),
        ),
        style: GoogleFonts.montserratAlternates(fontSize: 18),
      ),
    );
  }
}
