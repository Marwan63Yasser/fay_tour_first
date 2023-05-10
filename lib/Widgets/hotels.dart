//This File is imported in Area page (descScreen.dart) for view
//the hotels at this area in the bottom slider
import 'package:app4/Widgets/RatingStarsBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app4/Widgets/UpBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HOTELS extends StatelessWidget { 
  String area_name;
  HOTELS({Key? key, required this.area_name}) : super(key: key);

  @override  
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('hotels').where("area",isEqualTo: area_name).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : SingleChildScrollView( 
                    child: Column(
                      children: [
                        SizedBox( 
                          height: 200,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context,MaterialPageRoute(builder: ((context) => BAR(ro: snapshot.data?.docs[index]["name"], index: 1,img: snapshot.data?.docs[index]["image"]))));
                                },
                                child: Container(
                                  height: 100,
                                  width: 200,
                                  margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow:  const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 6, 
                                      //offset: Offset(4,4),
                                    ),]
                                  ),
                                  child: Column(
                                      children: [
                                        SizedBox(
                                          height: 133,
                                          width: 300,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.network(snapshot.data?.docs[index]["image"],
                                             fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset("images/error1.gif",fit: BoxFit.cover,);
                                            },
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if(loadingProgress != null) 
                                              {
                                                return Image.asset("images/loading2.gif",fit: BoxFit.cover,);
                                              }
                                              return child;
                                            },
                                            )),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                                          child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: Text(snapshot.data?.docs[index]["name"]+"",overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.alice(fontSize: 16,fontWeight: FontWeight.bold))),
                                                  Row(
                                                    children: [
                                                      Text("${snapshot.data?.docs[index]["rate"]}",style: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                                      RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 0),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                        ),
                                    
                                      ],
                                    ),
                                  ),
                              );
                            },
                            ),
                        )
                      ],
                    )
                  );
      }),
    );
  }
}