import 'package:app4/BottomBar.dart';
import 'package:app4/ResScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PAY extends StatelessWidget {
  String nights,price,name,img;
  PAY({required this.price,required this.nights,required this.name,required this.img});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
      
      centerTitle: true,
      title: Text("Payment",style: TextStyle(fontFamily: 'KaushanScript',fontWeight: FontWeight.bold),),
      foregroundColor: Colors.amber,
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
            alignment: Alignment.center,
            child: Container(child: Text("Total Price well be: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),margin: EdgeInsets.all(10),)
            ),

            Align(
            alignment: Alignment.center,
            child: Container(child: Text("${int.parse(nights)*int.parse(price)} USD",style: GoogleFonts.merriweather(fontSize: 18,color: Colors.white),),margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
            ),

            Container(
                      margin: EdgeInsets.fromLTRB(0,25,0,10),
                      child: SizedBox(
                        height: 55,
                        width: 260,
                        child: TextButton(
                          onPressed: (){
                            FirebaseFirestore.instance.collection("Reservations").add({
                                        "Email": user.email,
                                          "name": name,
                                          "image": img,
                                          "nights": nights,
                                          "price":price
                            });
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) =>DefaultTabController(length: 4, child: BottomBar(select: 2,)))), (route) => false);
                          }, 
                          child: Text("Confirm!",style: GoogleFonts.rye(color: Colors.black,fontSize: 18),),
                          style: TextButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                          ),
                          ),
                      ),
                    ),

          ],
          ) 
        ),
    );
  }
}

