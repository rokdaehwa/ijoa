import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ijoa/pages/home_page.dart';
import 'package:ijoa/pages/init_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아이조아 - 아동인지발달',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        accentColor: Colors.amber,
        // TODO: dark mode?
        // TODO: Text Theme
        // brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          headline4: GoogleFonts.notoSans(
            color: Colors.grey.shade800,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
          headline5: GoogleFonts.notoSans(
            color: Colors.grey.shade800,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText1: GoogleFonts.notoSans(
            color: Colors.grey.shade700,
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: GoogleFonts.notoSans(
            color: Colors.grey.shade700,
            fontSize: 14.0,
          ),
        ),
        cursorColor: Colors.amber
      ),
      debugShowCheckedModeBanner: false,
      home: InitPage(),
    );
  }
}
