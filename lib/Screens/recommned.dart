//the test page for recommended places (initial version)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RECOM extends StatelessWidget {
  const RECOM({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 30, 0, 10),
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
          QUESTION(q: "Do you like areas with bodies of water?", num: "1"),
          QUESTION(q: "Do you like archaeological areas?", num: "2"),
          QUESTION(q: "Do you like areas with greenery and trees?", num: "3"),
          QUESTION(q: "Do you like camping?", num: "4"),
      
           Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0,20,0,0),
            child: SizedBox(
              height: 55,
              width: 150,
              child: TextButton(
                onPressed: (){
      
                },
                child: Text("Recommend!",style: GoogleFonts.rye(color: Colors.lightGreen,fontSize: 18),),
                style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 0, 44, 3),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 10
                ),
                ),
            ),
          ),
        ],),
      ),
    );
  }
}


class QUESTION extends StatelessWidget {
  
  String q,num;
  QUESTION({Key? key, required this.q,required this.num}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
               
               Text("Q"+num+": "+q,style: GoogleFonts.merriweather(fontSize: 20,color:  Theme.of(context).colorScheme.onPrimary,fontWeight: FontWeight.bold),),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                        margin: const EdgeInsets.fromLTRB(0,10,0,10),
                        child: SizedBox(
                          height: 45,
                          width: 130,
                          child: TextButton(
                            onPressed: (){

                            },
                            child: Text("Yes",style: GoogleFonts.rye(color:  Theme.of(context).colorScheme.onSecondary,fontSize: 18),),
                            style: TextButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 10
                            ),
                            ),
                        ),
                      ),
                  Container(
                        margin: const EdgeInsets.fromLTRB(25,10,0,10),
                        child: SizedBox(
                          height: 45,
                          width: 130,
                          child: TextButton(
                            onPressed: (){

                            },
                            child: Text("No",style: GoogleFonts.rye(color:  Theme.of(context).colorScheme.onSecondary,fontSize: 18),),
                            style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 219, 16, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            elevation: 10
                            ),
                            ),
                        ),
                      ),
                ],
               )
            ],),
    );
  }
}