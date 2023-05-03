//This page will be show if the user want to go to an area
//show when clicking on (Go to it) botton in area page (descScreen.dart)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TRIP extends StatelessWidget {

  String ro;
  TRIP({Key? key, required this.ro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
      centerTitle: true, 
      title: Text("Go To "+ro+"...",style: GoogleFonts.acme()),
      foregroundColor: Colors.black,
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      ),
      body: Column(
        children: [
          Container(
                        margin: const EdgeInsets.fromLTRB(00, 120, 0, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: const Image(image: AssetImage("images/kkk.jpg")))
        ),

        Container(
          margin: const EdgeInsets.fromLTRB(0,25,0,10),
          child: SizedBox(
            height: 55,
            width: 260,
            child: TextButton(
              onPressed: (){
                
              },
              child: Text("Start the Trip!",style: GoogleFonts.rye(color: Colors.lightGreen,fontSize: 18),),
              style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 44, 3),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 10
              ),
              ),
          ),
        ),
        ],
      ),
    );
  }
}