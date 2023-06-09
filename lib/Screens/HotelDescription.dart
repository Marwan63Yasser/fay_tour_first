//This file is for viewing the details of the hotel if you click its card on
//the area page (descScreen.dart)

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';

 class HOTEL extends StatelessWidget {

  final user = FirebaseAuth.instance.currentUser!; 
  final _textFieldController = TextEditingController(); 

  String ro;
  HOTEL({Key? key, required this.ro}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("hotels").where("name",isEqualTo: ro).snapshots(),
      builder: ((context, snapshot) {
        return  (snapshot.connectionState == ConnectionState.waiting) ? Container()
        : Container(
      height: MediaQuery.of(context).size.height/1.49,
                  padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
                  decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                  )),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                              Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(child: Text(snapshot.data?.docs[0]["name"]+" Hotel",
                                  style: GoogleFonts.acme(fontSize: 22,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,maxLines: 2,
                                  ),
                                  margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                  ),
                                ),
 
                                Row(
                                  children: [
                                    Text('${snapshot.data?.docs[0]["rate"]}',style: const TextStyle(fontWeight: FontWeight.bold),),
                                    Container(
                                      margin: const EdgeInsets.only(right: 15),
                                      child: RatingBar(rating: snapshot.data?.docs[0]["rate"],size: 22,)
                                      ),
                                  ],
                                ),
                              ],
                            ),
          
                               Align(
                                 alignment: Alignment.center,
                                 child: Container(child: Text(snapshot.data?.docs[0]["desc"],
                                 style: GoogleFonts.merriweather(fontSize: 13,color: Theme.of(context).colorScheme.onPrimary),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)),

                                                    const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Expanded(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'images/e2.jpg',
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width*0.30,
                              height: MediaQuery.of(context).size.width*0.3,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Expanded(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            'images/e1.jpg',
                            fit: BoxFit.cover,
                           width: MediaQuery.of(context).size.width*0.30,
                              height: MediaQuery.of(context).size.width*0.3,
                          ),
                        )),
                      ),
                      InkWell(
                        onTap: () {
                          
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Expanded(
                              child: Container(
                           width: MediaQuery.of(context).size.width*0.30,
                              height: MediaQuery.of(context).size.width*0.3,
                            padding: const EdgeInsets.only(right: 5),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black26,
                                image: const DecorationImage(
                                    image: AssetImage('images/e3.jpg'),
                                    fit: BoxFit.cover,
                                    opacity: .4)),
                            child: const Text(
                              '+10',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w600),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                              Container(
                              margin: const EdgeInsets.fromLTRB(0,25,0,30),
                              child: SizedBox(
                                height: 55, 
                                width: 260,
                                child: TextButton(
                                  onPressed: (){},
                                  child: Text("Reserve!",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary,fontSize: 18),),
                                  style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  elevation: 10
                                  ),
                                  ),
                              ),
                            ),
          
                            // Align(
                            //     alignment: Alignment.center,
                            //     child: Container(child: Text("OR",style: GoogleFonts.merriweather(fontSize: 17,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),margin: const EdgeInsets.all(10),)
                            //     ),
                              
                            //checkFav(ro: ro, name: snapshot.data?.docs[0]["name"], image: snapshot.data?.docs[0]["image"]),
          
          
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



