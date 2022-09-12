import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

class RESERVE extends StatefulWidget {
  const RESERVE({Key? key}) : super(key: key);

  @override
  State<RESERVE> createState() => _RESERVEState();
}

class _RESERVEState extends State<RESERVE> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Reservations').where("Email",isEqualTo: user.email).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : (snapshot.data!.docs.length == 0)
                ?Center(child: Text("Nothing Yet",style: GoogleFonts.pressStart2p(fontSize: 25,color: Colors.amber)),)
                :ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              //Navigator.push(context,MaterialPageRoute(builder: ((context) => BAR(ro: snapshot.data?.docs[index]["Fav"]))));
                            },
                            child: Card(
                              child: ListTile(
                                leading: Image(image: NetworkImage(snapshot.data?.docs[index]["image"])),
                                title: Text("${snapshot.data?.docs[index]["name"]} (Nights: ${snapshot.data?.docs[index]["nights"]})       (Total Cost: ${int.parse(snapshot.data?.docs[index]["price"])*int.parse(snapshot.data?.docs[index]["nights"])} USD)",
                                style: GoogleFonts.merriweather(),
                                ),
                                trailing: IconButton(onPressed: () async {
                                  DocumentReference documentReference = FirebaseFirestore.instance.collection('Reservations').doc(snapshot.data?.docs[index].id);
                                  await documentReference.delete();                                  
                                },
                                icon: Icon(Icons.cancel),
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                      
                    },
        );
      }),
    );
  }
}