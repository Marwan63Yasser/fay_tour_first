//This file is for viewing the details of the area if you click its card on
//the explore page 
import 'package:app4/Data/CheckFavorite.dart';
import 'package:app4/Widgets/hotels.dart';
import 'package:app4/Screens/Trip.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';
import 'package:google_fonts/google_fonts.dart';

class Desc extends StatelessWidget {
  String ro;
  Desc({Key? key, required this.ro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Areas").where("name",isEqualTo: ro).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting) ? const CircularProgressIndicator()
        : Container(
                  height: MediaQuery.of(context).size.height/1.49,
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )),
                    child: ListView(
                     children: [
                      Padding(
                        padding: const EdgeInsets.only(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //GetData(collection: "Area", isSearch: true,type: 1,SearchKey1: widget.ro,SearchKey2: "name",),
                            Align(
          alignment: Alignment.center,
          child: Container(child: Text(snapshot.data?.docs[0]["name"],
          style: GoogleFonts.acme(fontSize: 22,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
      ),
        Align(
          alignment: Alignment.center,
          child: Container(child: Text(snapshot.data?.docs[0]["desc"],
          style: GoogleFonts.merriweather(fontSize: 18,color: Theme.of(context).colorScheme.onPrimary),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
      ),
      Align(
        alignment: Alignment.center,
        child: Container(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text("Rate: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.onPrimary),),
          RatingBar(rating: snapshot.data?.docs[0]["rate"], ratingCount: 25,size: 22,),
          ],
        ),
        margin: const EdgeInsets.all(10),)
        ),
                                Container(
                                margin: const EdgeInsets.fromLTRB(0,25,0,10),
                                child: SizedBox(
                                  height: 55,
                                  width: 260,
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.push(context,MaterialPageRoute(builder: ((context) => TRIP(ro: snapshot.data?.docs[0]["name"]))));
                                    },
                                    child: Text("Go to it!",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary,fontSize: 18),),
                                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    elevation: 10
                                    ),
                                    ),
                                ),
                              ),

                              Align(
                                  alignment: Alignment.center,
                                  child: Container(child: Text("OR",style: GoogleFonts.merriweather(fontSize: 17,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),margin: const EdgeInsets.all(10),)
                                  ),
                                
                                checkFav(ro: ro, name: snapshot.data?.docs[0]["name"], image: snapshot.data?.docs[0]["image"]),

                                Align(
                                  alignment: Alignment.center,
                                  child: Container(child: Text("The Near Hotels: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.secondary),),margin: const EdgeInsets.all(20),)),
                        
                        HOTELS(area_name: snapshot.data?.docs[0]["name"]),

                        ],
                        
                        ),
                        )
                     ],

                    ),
  );
      }),
    );
  }
}



 