import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:app4/Widgets/RatingStarsBar.dart';

class AreaCard extends StatelessWidget {
  final snapshot;
  int index;
  AreaCard({Key? key, required this.snapshot,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 17,vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,//const Color(0xff272727),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                        color: Colors.grey,//Theme.of(context).colorScheme.primary,
                        blurRadius:6, 
                      ),            
                      ]
                    ),

                    child: Column(
                      children: [
                        ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                            child: Image.network(snapshot.data?.docs[index]["image"]),
                            ),
                      
                       const SizedBox(height: 10,) ,
                        Container(
                          margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(snapshot.data?.docs[index]["name"],style: GoogleFonts.alice(color: Theme.of(context).colorScheme.onPrimary,fontSize: 20,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2),
                              RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 25)
                             
                            ],),
                        ),
                     const SizedBox(height: 10,) 
                    ]
                  ),
              );
  }
}