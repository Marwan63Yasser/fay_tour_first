//This file is for (The Explore page) which contains the video and 
//the areas cards
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app4/Widgets/UpBar.dart';
import 'package:app4/Widgets/AreaCard.dart';

class EXPLORE extends StatefulWidget { 
  const EXPLORE({Key? key}) : super(key: key);
  @override
  State<EXPLORE> createState() => _EXPLOREState();
}

class _EXPLOREState extends State<EXPLORE> {

  final YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: 'jJaYKCj9K_8',flags: const YoutubePlayerFlags(
    
    autoPlay: false,mute: false,showLiveFullscreenButton: false,
  ),
  );
  
  var category = [
      'Best Places',
      'Most Visited',
      'New Added',
      'Hotels',
    ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(controller: _controller),
                builder: (context,player){
                  return Column(
                    children: [
                      player,
                    ],
                  );
                },
              ),
            ),

            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      
                      for (int i = 0; i < category.length; i++)
                      Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.all(5),
                            
                            
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                 
                                });
                              },
                              style: TextButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary, //const Color(0xff272727),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 5,
                            ),
                              child: Text(category[i],
                                style:  GoogleFonts.acme(
                                    fontSize: 20, fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.onPrimary),
                              ),
                      ),)
                    ],
                  ),
                ), 
              ),

            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Areas").snapshots(),
              builder: ((context,snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting) ? const CircularProgressIndicator()
                : Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:(context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context,MaterialPageRoute(builder: ((context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["image"],index: 0,))));
                  },
                  child: AreaCard(snapshot: snapshot, index: index)
                );
              },
            ),
          );
              })
              
            ),
            //GetData(collection: "Areas", isSearch: false,type: 0,),
        ],
      );
  }
}
