import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app4/Widgets/BottomBar.dart';

class checkFav extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  String ro,name,image;
  checkFav({Key? key, required this.ro,required this.name,required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Favourite').where("Fav",isEqualTo: ro).where("Email",isEqualTo: user.email).snapshots(),
      builder: (context, snapshot) {
        return Container(
                      margin: const EdgeInsets.fromLTRB(0,10,0,0),
                      child: SizedBox(
                        height: 55,
                        width: 260,
                        child: TextButton(
                          onPressed: (){
                            if(snapshot.data!.docs.isEmpty)
                            {
                              FirebaseFirestore.instance.collection("Favourite").add({
                                "Email": user.email,
                                "Fav": name,
                                "image": image,
                                "type": "area",});

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) =>const DefaultTabController(length: 4, child: BottomBar(select: 1,)))), (route) => false);
                            }
                            else
                            {
                                    showDialog(context: context,
                                    barrierDismissible: false, 
                                    builder: (context) {
                                      return AlertDialog(
                                      title: Text("This area already exists in the Favourite list!",style: GoogleFonts.merriweather(),),
                                      actions: [
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: Text("Okay",style: GoogleFonts.rye(color: Colors.black),),
                                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
                                          ),
                                        )
                                      ],
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    );
                                    }
                                    );
                            }

                      
                          }, child: Text("Add to Favourites",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.onSecondary,fontSize: 18),),
                          style: TextButton.styleFrom(backgroundColor: const Color.fromARGB(255, 220, 109, 101),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 10
                          ),
                          ),
                      ),
        );
      }
    );
  }
}
