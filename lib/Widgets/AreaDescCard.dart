import 'package:flutter/material.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';
import 'package:google_fonts/google_fonts.dart';

class AreaDescCard extends StatelessWidget { 
  final snapshot;
  const AreaDescCard({Key? key, required this.snapshot}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context,index){
        return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(child: Text(snapshot.data?.docs[index]["name"],style: GoogleFonts.acme(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
      ),
        Align(
          alignment: Alignment.center,
          child: Container(child: Text(snapshot.data?.docs[index]["desc"],style: GoogleFonts.merriweather(fontSize: 18,color: Colors.white),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
      ),
      Align(
        alignment: Alignment.center,
        child: Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Rate: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green),),
          RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 25,size: 22,),
          ],
        ),
        margin: const EdgeInsets.all(10),)
        ),
      ],
    );
      });
  }
}