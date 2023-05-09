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

  final YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: 'AloFpu8KyO8',flags: const YoutubePlayerFlags(
    
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
    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection("Areas").snapshots(),
                      builder: ((context,snapshot) {
                        return (snapshot.connectionState == ConnectionState.waiting) ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder:(context, index) {
                        return Column(
                          children: [
                            
          (index == 0) ? Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
                children: [
                
                   // ------------------Youtube Player----------------------
                   SizedBox(
                    height:  MediaQuery.of(context).size.height*0.25,
                    width: MediaQuery.of(context).size.width*0.92,
                     child: ClipRRect(
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
                   ),
                    const SizedBox(height: 10,),
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
                                            fontSize: 18, fontWeight: FontWeight.w600,color: Theme.of(context).colorScheme.onPrimary),
                                      ),
                              ),)
                            ],
                          ),
                        ), 
                      ),
                    const SizedBox(height: 5,),

                    //GetData(collection: "Areas", isSearch: false,type: 0,),

                ],
              ),

              
        ):Container(),
                            // InkWell(
                            //     onTap: () {
                            //       // Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["images"][0],index: 0,)
                            //       // )
                            //       // );
                                    
                            //     },
                            //     child: Container(
                            //       height: 150,
                            //       width: 200,
                            //       decoration: BoxDecoration(
                            //       color: Theme.of(context).colorScheme.secondary,
                            //       borderRadius: BorderRadius.circular(10),
                            //       boxShadow:  const [
                            //       BoxShadow(
                            //         color: Colors.grey,
                            //         blurRadius: 6, 
                            //         //offset: Offset(4,4),
                            //       ),]
                            //     ),
                            //     child: Stack(
                            //       fit: StackFit.expand,
                            //       children: [
                            //         ShaderMask(
                            //                 shaderCallback: (rect) {
                            //                   return const LinearGradient(
                            //                     begin: Alignment.topCenter,
                            //                     end: Alignment.bottomCenter,
                            //                     colors: [
                            //                       Colors.transparent,
                            //                       Colors.black,
                            //                       Colors.black,
                            //                       Colors.transparent,
                            //                     ],
                            //                     stops: [0, 0.2, 0.8, 1],
                            //                     ).createShader(
                            //                       Rect.fromLTRB(0, 0, rect.width, rect.height)
                            //                     );
                            //                 },
                            //                 blendMode: BlendMode.dstIn,
                            //                 child: ClipRRect(
                            //                 borderRadius: BorderRadius.circular(7),
                            //                 child: Image.network(snapshot.data?.docs[index]["images"][0],
                            //                 fit: BoxFit.cover,
                            //                 errorBuilder: (context, error, stackTrace) {
                            //                   return Image.asset("images/error1.gif");
                            //                 },
                            //                 loadingBuilder: (context, child, loadingProgress) {
                            //                   if(loadingProgress != null) 
                            //                   {
                            //                     return Image.asset("images/loading5.gif");
                            //                   }
                            //                   return child;
                            //                 },
                            //                 ),
                            //                 ),
                            //               ),
                            //         Row(
                            //           mainAxisAlignment: MainAxisAlignment.center,
                            //           crossAxisAlignment: CrossAxisAlignment.end,
                            //           children: const [
                            //             Text("data"),
                            //           ],
                            //         )
                            //       ],
                            //     ),
                            //     ),
                            //   )


                            InkWell(
                              onTap: () {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["images"][0],index: 0,)
                                )
                                );
                
                              },
                              child: AreaCard(snapshot: snapshot, index: index)
                            ),
                          ],
                        );
                      },
                    );
                      })
                      
                    );
  }
}
