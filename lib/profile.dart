import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';


class PROFILE extends StatefulWidget {
  const PROFILE({Key? key}) : super(key: key);

  @override
  State<PROFILE> createState() => _PROFILEState();
}

class _PROFILEState extends State<PROFILE> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Student').where("Email",isEqualTo: user.email).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage("images/zzz.png"),
                              radius: 100,
                            ),

                            Container(
                              child: Text("Name: ",
                              style: GoogleFonts.merriweather(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                              margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                            ),


                            Container(
                              child: Text("${snapshot.data?.docs[index]["FirstName"]} ${snapshot.data?.docs[index]["LastName"]}",
                              style: GoogleFonts.quicksand(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),


                            Container(
                              child: Text("Email: ",
                              style: GoogleFonts.merriweather(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                              margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                            ),


                            Container(
                              child: Text(snapshot.data?.docs[index]["Email"],
                              style: GoogleFonts.quicksand(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),


                            Container(
                              child: Text("Mobile: ",
                              style: GoogleFonts.merriweather(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                              margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                            ),


                            Container(
                              child: Text(snapshot.data?.docs[index]["Mobile"],
                              style: GoogleFonts.quicksand(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),


                            Container(
                              child: Text("Password: ",
                              style: GoogleFonts.merriweather(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
                              margin: EdgeInsets.fromLTRB(0, 13, 0, 10),
                            ),


                            Container(
                              child: Text(snapshot.data?.docs[index]["Password"],
                              style: GoogleFonts.quicksand(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.amber),),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            ),

                              Container(
                      margin: EdgeInsets.fromLTRB(0,22,0,10),
                      child: SizedBox(
                        height: 55,
                        width: 260,
                        child: TextButton(
                          onPressed: (){
                            FirebaseAuth.instance.signOut();
                          }, child: Text("Sign Out",style: GoogleFonts.rye(color: Colors.black,fontSize: 18),),
                          style: TextButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                          ),
                          ),
                      ),
                    ),

                          ],
                        ),
                      );
                    },

                    
        );
      })
      
      );
  }

}