import 'package:app4/BottomBar.dart';
import 'package:app4/payment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

 class Desc extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  final _textFieldController = TextEditingController();
  String ro;
  Desc({required this.ro});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Rooms').where("name",isEqualTo: ro).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return Column(
                                children: [
                      Container(
                        child: Image(image: NetworkImage(snapshot.data?.docs[index]["image"]))
                        ), 
                        
                      Align(
                        alignment: Alignment.center,
                        child: Container(child: Text("Description: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),margin: EdgeInsets.all(10),)),

                      Align(
                        alignment: Alignment.center,
                        child: Container(child: Text(snapshot.data?.docs[index]["desc"],style: GoogleFonts.merriweather(fontSize: 18,color: Colors.white),),margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),)),


                      Align(
                        alignment: Alignment.center,
                        child: Container(child: Text("Price: ",style: GoogleFonts.rye(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),margin: EdgeInsets.all(10),)),

                      Align(
                        alignment: Alignment.center,
                        child: Container(child: Text("${snapshot.data?.docs[index]["price"]} USD / night",style: GoogleFonts.merriweather(fontSize: 18,color: Colors.white),),margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),)),


                      Container(
                      margin: EdgeInsets.fromLTRB(0,25,0,10),
                      child: SizedBox(
                        height: 55,
                        width: 260,
                        child: TextButton(
                          onPressed: (){
                            showDialog(context: context,
                                  barrierDismissible: false, 
                                  builder: (context) {
                                    return AlertDialog(
                                    title: Text("How many nights?",style: GoogleFonts.merriweather(),),
                                    content: TextField(
                                      autofocus: true,
                                      controller: _textFieldController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(hintText: "for example: 3",
                                      ),
                                    ),
                                    actions: [
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: (){
                                          Navigator.of(context).pop();
                                          Navigator.push(context,MaterialPageRoute(builder: ((context) => PAY(price: snapshot.data?.docs[index]["price"], nights: _textFieldController.text,name: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["image"],))));
                                        }, child: Text("Enter",style: GoogleFonts.rye(color: Colors.black),),
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
                                        ),
                                      )
                                    ],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  );
                                  }
                                  );
                          }, child: Text("Reserve!",style: GoogleFonts.rye(color: Colors.black,fontSize: 18),),
                          style: TextButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                          ),
                          ),
                      ),
                    ),

                    Align(
                        alignment: Alignment.center,
                        child: Container(child: Text("OR",style: GoogleFonts.merriweather(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.grey),),margin: EdgeInsets.all(10),)
                        ),
                      
                    Container(
                      margin: EdgeInsets.fromLTRB(0,10,0,0),
                      child: SizedBox(
                        height: 55,
                        width: 260,
                        child: TextButton(
                          onPressed: (){
                            FirebaseFirestore.instance.collection("Favourite").add({
                                "Email": user.email,
                                "Fav": snapshot.data?.docs[index]["name"],
                                "image": snapshot.data?.docs[index]["image"],
                          });
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) =>DefaultTabController(length: 4, child: BottomBar(select: 1,)))), (route) => false);
                          }, child: Text("Add to Favourites",style: GoogleFonts.rye(color: Colors.black,fontSize: 18),),
                          style: TextButton.styleFrom(backgroundColor: Color.fromARGB(255, 220, 109, 101),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                          ),
                          ),
                      ),
                    ),


                    ],

      );

          },
        );
      }),

    );
  }
}
