import 'package:flutter/material.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';

class AreaCard extends StatelessWidget {
  final snapshot;
  int index;
  AreaCard({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.90,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                snapshot.data?.docs[index]["images"][0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "images/error1.gif",
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return Image.asset(
                      "images/loading2.gif",
                      fit: BoxFit.cover,
                    );
                  }
                  return child;
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    snapshot.data?.docs[index]["name"],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                // const Icon(
                //   Icons.more_vert,
                //   size: 30,
                // )
                Row(
                  children: [
                    Text(
                      '${snapshot.data?.docs[index]["rate"]}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    RatingBar(
                        rating: snapshot.data?.docs[index]["rate"],
                        ratingCount: 0),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // Row(
          //   children: const [
          //     Icon(
          //       Icons.star,
          //       size: 20,
          //       color: Colors.amber,
          //     ),
          //     Text(
          //       '4.5',
          //       style: TextStyle(fontWeight: FontWeight.w600),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}






///////---------------------------------Old Design----------------------------------------------/////////
// Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 17,vertical: 12),
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.secondary,//const Color(0xff272727),
//                       borderRadius: BorderRadius.circular(15),
//                       boxShadow: const [
//                         BoxShadow(
//                         color: Colors.grey,//Theme.of(context).colorScheme.primary,
//                         blurRadius:6, 
//                       ),            
//                       ]
//                     ),

//                     child: Column(
//                       children: [
//                         ClipRRect(
//                             borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
//                             child: Image.network(snapshot.data?.docs[index]["image"],
//                              fit: BoxFit.cover,
//                                         errorBuilder: (context, error, stackTrace) {
//                                           return Image.asset("images/error1.gif");
//                                         },
//                                         loadingBuilder: (context, child, loadingProgress) {
//                                           if(loadingProgress != null) 
//                                           {
//                                             return Image.asset("images/loading2.gif");
//                                           }
//                                           return child;
//                                         },
//                             ),
//                             ),
                      
//                        const SizedBox(height: 10,) ,
//                         Container(
//                           margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(snapshot.data?.docs[index]["name"],style: GoogleFonts.alice(color: Theme.of(context).colorScheme.onPrimary,fontSize: 20,fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis,maxLines: 2),
//                               RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 25)
                             
//                             ],),
//                         ),
//                      const SizedBox(height: 10,) 
//                     ]
//                   ),
//               );