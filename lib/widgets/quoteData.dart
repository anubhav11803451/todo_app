import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:todo_app/models/quotemodel.dart';

class QuoteData extends StatefulWidget {
  QuoteData({Key key}) : super(key: key);

  @override
  _QuoteDataState createState() => _QuoteDataState();
}

// call the API and fetch the response
Future<QuoteModel> fetchQuotes() async {
  final response = await http.get('https://favqs.com/api/qotd');
  if (response.statusCode == 200) {
    return QuoteModel.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load Quote');
  }
}

class _QuoteDataState extends State<QuoteData>
    with SingleTickerProviderStateMixin {
  // QuoteModel quoteModel;
  // Quote quote;
  // AnimationController _animationController;
  // Animation<Color> _colorTween;

  // Future<void> fetchQuotes() async {
  //   var response = await http.get('https://favqs.com/api/qotd');
  //   // var jsonData = jsonDecode(response.body);
  //   // quoteModel = QuoteModel.fromJson(jsonData);
  //   // quote = quoteModel.quote;
  //   if (response.statusCode == 200) {
  //     return quote = QuoteModel.fromJson(json.decode(response.body)).quote;
  //   } else {
  //     throw Exception('Failed to load Quote');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   duration: Duration(milliseconds: 500),
    //   vsync: this,
    // );
    // _colorTween = _animationController
    //     .drive(ColorTween(begin: Colors.deepPurple[100], end: Colors.white));
    fetchQuotes();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuoteModel>(
      future: fetchQuotes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            // decoration: BoxDecoration(
            //   // color: Colors.white,
            //   image: DecorationImage(
            //       image: AssetImage('assets/images/quo.png'), fit: BoxFit.fill),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            padding: EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SelectableText(
                  snapshot.data.quoteText,
                  showCursor: true,
                  cursorColor: Colors.deepPurple[100],
                  cursorWidth: 2,
                  style: GoogleFonts.indieFlower(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '_ ' + snapshot.data.quoteAuthor,
                    style: GoogleFonts.indieFlower(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text(
            '${snapshot.error}',
            style: GoogleFonts.indieFlower(
                color: Colors.redAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          );
        } else {
          return Center(
            // child: CircularProgressIndicator(
            //   backgroundColor: Colors.white,
            //   valueColor: _colorTween,
            // ),
            child: Text(
              'Quotes of the day...',
              style: GoogleFonts.indieFlower(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
      },
    );
  }
}
