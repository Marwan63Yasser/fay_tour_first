//This file is for viewing the details of the area if you click its card on
//the explore page 
import 'package:app4/Widgets/hotels.dart';
import 'package:app4/Screens/Gallery.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';

import 'package:app4/Widgets/stars.dart';
import 'package:url_launcher/url_launcher.dart';


class Desc extends StatelessWidget {
  String ro;
  Desc({Key? key, required this.ro}) : super(key: key);

  final urlImages = [
    'images/e1.jpg',
    'images/e2.jpg',
    'images/e3.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Areas").where("name",isEqualTo: ro).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting) ?  Container()
        : Container(
                  height: MediaQuery.of(context).size.height/1.49,
                  padding: const EdgeInsets.only(top: 20, left: 0, right: 0),
                  decoration: BoxDecoration(
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
                            //GetData(collection: "Area", isSearch: true,type: 1,SearchKey1: widget.ro,SearchKey2: "name",),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(child: Text(snapshot.data?.docs[0]["name"],
                                  style: GoogleFonts.acme(fontSize: 22,color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold
                                  ),
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
          style: GoogleFonts.merriweather(fontSize: 13,color: Theme.of(context).colorScheme.onPrimary),),margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),)
      ),

                      const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: InkWell(
                                onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context) => GalleryWidget(urlImages: snapshot.data?.docs[0]["images"],index: 0) ) ),
                                child: SizedBox(
                                width: MediaQuery.of(context).size.width*0.30,
                                height: MediaQuery.of(context).size.width*0.3,
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                  snapshot.data?.docs[0]["images"][0],
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
                                  ),
                                  ),
                                ),
                              )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child:InkWell(
                                onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context) => GalleryWidget(urlImages: snapshot.data?.docs[0]["images"],index: 1) ) ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.30,
                                height: MediaQuery.of(context).size.width*0.3,
                                  child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                  snapshot.data?.docs[0]["images"][1],
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
                                                              
                                ),
                                ),
                                ),
                              )
                        ),

                                                Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child:InkWell(
                                onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context) => GalleryWidget(urlImages: snapshot.data?.docs[0]["images"],index: 2) ) ),
                                child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Opacity(
                                        opacity: 0.6,
                                        child: SizedBox(
                                          width: MediaQuery.of(context).size.width*0.30,
                                                                      height: MediaQuery.of(context).size.width*0.3,
                                          child: ClipRRect(
                                          borderRadius: BorderRadius.circular(15),
                                          child: Image.network(
                                          snapshot.data?.docs[0]["images"][2],
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
                                                                      
                                           ),
                                          ),
                                        ),
                                      ),
                                    Text(
                                "+${snapshot.data?.docs[0]["images"].length - 2}",
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600),
                              ),
                                    ],
                                  ),
                                
                              )
                        ),

                      ],
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),

                RatingScreen(ro: ro, PlaceType: 0),

                                Container(
                                margin: const EdgeInsets.fromLTRB(0,25,0,10),
                                child: SizedBox(
                                  height: 55,
                                  width: 260,
                                  child: TextButton(
                                    onPressed: () async {
                                    String  url = "https://www.google.com/maps/search/?api=1&query=${snapshot.data?.docs[0]["DestinationLatitude"]},${snapshot.data?.docs[0]["DestinationLongitude"]}";
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    } else {
                                      throw 'Could not launch $url';
                                    }
                                    },
                                    child: Text("Go to it!",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary,fontSize: 18),),
                                    style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                    elevation: 10
                                    ),
                                    ),
                                ),
                              ),

                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(child: Text("The Near Hotels: ",style: GoogleFonts.acme(fontSize: 22,fontWeight: FontWeight.bold,color: Theme.of(context).colorScheme.primary),),margin: const EdgeInsets.all(20),)
                                  ),
                        
                        

                        HOTELS(area_name: snapshot.data?.docs[0]["name"]),


                        const SizedBox(height: 15,),
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

