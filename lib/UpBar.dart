import 'package:app4/descScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BAR extends StatelessWidget {
  String ro; 
  BAR({required this.ro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
      centerTitle: true,
      title: Text(ro,style: GoogleFonts.acme()),
      foregroundColor: Colors.amber,
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: Desc(ro: ro),
    );
  }
}
