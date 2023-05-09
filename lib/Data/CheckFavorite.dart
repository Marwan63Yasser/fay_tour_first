import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class checkFav extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;
  String ro,image;
  int PlaceType; // 0--->area | 1--->hotel
  checkFav({Key? key, required this.ro,required this.image,required this.PlaceType}) : super(key: key);

  @override
  Widget build(BuildContext context) { 
    return  StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Favourite').where("Fav",isEqualTo: ro).where("Email",isEqualTo: user.email).snapshots(),
      builder: (context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting) ?  Container()
        :  Container(
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                          onPressed: (){
                            if(snapshot.data!.docs.isEmpty)
                            {
                              FirebaseFirestore.instance.collection("Favourite").add({
                                "Email": user.email,
                                "Fav": ro,
                                "image": image,
                                "type": (PlaceType == 0) ? "area" : "hotel",
                                });


                            //Fluttertoast.showToast(msg: "msg",);
                            //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context) =>const DefaultTabController(length: 4, child: BottomBar(select: 1,)))), (route) => false);

                           showDialog(context: context,
                                    barrierDismissible: false, 
                                    builder: (context) {
                                      return AlertDialog(
                                      title: Text("Adding Successful",style: GoogleFonts.merriweather(),),
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
                            else
                            {
                              DocumentReference documentReference = FirebaseFirestore.instance.collection('Favourite').doc(snapshot.data?.docs[0].id);
                              documentReference.delete();
                            }

                      
                          }, 
                          icon: (snapshot.data!.docs.isEmpty) ? const Icon(Icons.favorite_border_rounded,color: Colors.red,size: 40,) 
                          : const Icon(Icons.favorite,color: Colors.red,size: 40,),
                          ),
        );
      }
    );
  }
}
