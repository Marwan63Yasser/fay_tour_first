import 'package:app4/UpBar.dart';
import 'package:app4/descScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

class EXPLORE extends StatefulWidget {
  const EXPLORE({Key? key}) : super(key: key);

  @override
  State<EXPLORE> createState() => _EXPLOREState();
}

class _EXPLOREState extends State<EXPLORE> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Rooms').snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data!.docs.length, 
                  itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: ((context) => BAR(ro: snapshot.data?.docs[index]["name"]))));
                        },
                        child: GridTile(
                          footer: Center(child: Text(snapshot.data?.docs[index]["name"],style: GoogleFonts.alice(color: Colors.amber,fontSize: 17,fontWeight: FontWeight.bold),)),
                          child: Container(
                              margin: const EdgeInsets.all(5),
                              height: 300,
                               width: 160,
        
                              decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(snapshot.data?.docs[index]["image"]),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(100))
                                    ),
                                    ),
                          ),
                      );
                    },
                  
                  );
      }),

    );
  }
}