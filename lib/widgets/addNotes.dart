import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNotes extends StatelessWidget {
  final TextEditingController notesContentController;
  final TextEditingController notesTitleController;
  final String intialContentValue;
  final String intialTitleValue;
  final void Function(String initialValue) onChangedCon;
  final void Function(String initialValue) onChangedTi;
  const AddNotes({
    Key key,
    this.notesTitleController,
    this.notesContentController,
    this.intialContentValue,
    this.onChangedCon,
    this.intialTitleValue,
    this.onChangedTi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.only(top: 30, bottom: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
      child: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        // margin: EdgeInsets.only(top: 30, bottom: 5),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            TextFormField(
              controller: notesTitleController,
              cursorColor: Colors.deepPurple[200],
              initialValue: intialTitleValue,
              onChanged: onChangedTi,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.deepPurple[100], width: 2.0),
                ),
                hintText: "Title",
                hintStyle: GoogleFonts.montserrat(
                  fontSize: 18,
                ),
              ),
              style: GoogleFonts.montserratAlternates(fontSize: 18),
            ),
            Expanded(
              child: TextFormField(
                controller: notesContentController,
                initialValue: intialContentValue,
                onChanged: onChangedCon,
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
                style: GoogleFonts.montserratAlternates(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
