//This file is for (The Explore page) which contains the video and 
//the areas cards

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app4/Widgets/RatingStarsBar.dart';
import 'package:app4/Widgets/UpBar.dart';

class EXPLORE extends StatefulWidget { 
  const EXPLORE({Key? key}) : super(key: key);
  @override
  State<EXPLORE> createState() => _EXPLOREState();
}

class _EXPLOREState extends State<EXPLORE> {

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'BBHwtDhfydI',flags: const YoutubePlayerFlags(
    autoPlay: false,mute: false,showLiveFullscreenButton: false,
    forceHD: true,
  ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                    children: [
                    
                       // ------------------Youtube Player----------------------
                       SizedBox(
                        height:  MediaQuery.of(context).size.height*0.2608,
                        //width: MediaQuery.of(context).size.width*0.90,
                        child: YoutubePlayerBuilder(
      
                                player: YoutubePlayer(
                                  actionsPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                                  controller: _controller,
                                  onReady: () {
                                    //_controller.fitHeight(Size.fromHeight(MediaQuery.of(context).size.height*0.2608));
                                    //_controller.fitWidth(Size.fromWidth(MediaQuery.of(context).size.width));
                                  },
                                  onEnded: (data) {
                                        _controller.seekTo(Duration.zero); // Stop the player when the video ends
                                        _controller.pause();
                                      },
                                  showVideoProgressIndicator: true,
                                  bottomActions: [
                                    CurrentPosition(),
                                    ProgressBar(
                                      isExpanded: true,
                                      colors: const ProgressBarColors(
                                        playedColor: Color.fromARGB(255, 107, 161, 131),
                                        handleColor: Color.fromARGB(255, 27, 70, 29)
                                      ), 
                                    ),
                                    const PlaybackSpeedButton(),
                                    
                                  ],
                                  ),
                                builder: (context,player){
                                  return Column(
                                    children: [
                                      player,
                                     
                                    ],
                                  );
                                },
                              ),
                            
                       ),
                        
                        const SizedBox(height: 10,),
                      
                      SingleChildScrollView( 
                    child: Column(
                      children: [
                         StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Areas").snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                   Text("Torism Areas",
                                  style: GoogleFonts.alata(fontSize: 18),
                                  ),
                                  Row(
                                    children:  [
                                      Text("See More",
                                     style: GoogleFonts.alata(fontSize: 18),
                                      ),
                                      const Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ],
                              )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.25,
                              
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                                    //height: 200,
                                                    width: MediaQuery.of(context).size.width*0.7,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
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
                                                  child: InkWell(
                                                    onTap: () {
                                                      _controller.pause();
                                                       Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["images"][0],index: 0,)
                                                        )
                                                        );
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        ShaderMask(
                                                                shaderCallback: (rect) {
                                                                  return const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Colors.transparent,
                                                                      Colors.black,
                                                                      Colors.black,
                                                                      Colors.transparent,
                                                                    ],
                                                                    stops: [0, 0, 0.6, 1],
                                                                    ).createShader(
                                                                      Rect.fromLTRB(0, 0, rect.width, rect.height)
                                                                    );
                                                                },
                                                                blendMode: BlendMode.dstIn,
                                                                child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(7),
                                                                child: Image.network(snapshot.data?.docs[index]["images"][0],
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
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children:  [
                                                              Expanded(
                                                                child: Text(snapshot.data?.docs[index]["name"],
                                                                style: GoogleFonts.alata(fontSize: 15),
                                                                overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("${snapshot.data?.docs[index]["rate"]}",style: const TextStyle(fontSize: 15),),
                                                                  RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 0),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  );
                                },
                                ),
                            )
                          ],
                        );
}),
),

                         StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("hotels").snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                   Text("Hotels",
                                  style: GoogleFonts.alata(fontSize: 18),
                                  ),
                                  Row(
                                    children:  [
                                      Text("See More",
                                     style: GoogleFonts.alata(fontSize: 18),
                                      ),
                                      const Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ],
                              )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.25,
                              
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                                    //height: 200,
                                                    width: MediaQuery.of(context).size.width*0.7,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
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
                                                  child: InkWell(
                                                    onTap: () {
                                                      _controller.pause();
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["image"],index: 1,)
                                                        )
                                                        );

                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        ShaderMask(
                                                                shaderCallback: (rect) {
                                                                  return const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Colors.transparent,
                                                                      Colors.black,
                                                                      Colors.black,
                                                                      Colors.transparent,
                                                                    ],
                                                                    stops: [0, 0, 0.6, 1],
                                                                    ).createShader(
                                                                      Rect.fromLTRB(0, 0, rect.width, rect.height)
                                                                    );
                                                                },
                                                                blendMode: BlendMode.dstIn,
                                                                child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(7),
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
                                                                  ),
                                                                
                                                                ),
                                                              ),
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children:  [
                                                              Expanded(
                                                                child: Text(snapshot.data?.docs[index]["name"],
                                                                style: GoogleFonts.alata(fontSize: 15),
                                                                overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                   Text("${snapshot.data?.docs[index]["rate"]}",style: const TextStyle(fontSize: 15),),
                                                                  RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 0),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  );
                                },
                                ),
                            )
                          ],
                        );
}),
),

                         StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Areas").snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                   Text("Best Places",
                                  style: GoogleFonts.alata(fontSize: 18),
                                  ),
                                  Row(
                                    children:  [
                                      Text("See More",
                                     style: GoogleFonts.alata(fontSize: 18),
                                      ),
                                      const Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ],
                              )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.25,
                              
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                                    //height: 200,
                                                    width: MediaQuery.of(context).size.width*0.7,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
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
                                                  child: InkWell(
                                                    onTap: () {
                                                      _controller.pause();
                                                       Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["images"][0],index: 0,)
                                                        )
                                                        );
                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        ShaderMask(
                                                                shaderCallback: (rect) {
                                                                  return const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Colors.transparent,
                                                                      Colors.black,
                                                                      Colors.black,
                                                                      Colors.transparent,
                                                                    ],
                                                                    stops: [0, 0, 0.6, 1],
                                                                    ).createShader(
                                                                      Rect.fromLTRB(0, 0, rect.width, rect.height)
                                                                    );
                                                                },
                                                                blendMode: BlendMode.dstIn,
                                                                child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(7),
                                                                child: Image.network(snapshot.data?.docs[index]["images"][0],
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
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children:  [
                                                              Expanded(
                                                                child: Text(snapshot.data?.docs[index]["name"],
                                                                style: GoogleFonts.alata(fontSize: 15),
                                                                overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text("${snapshot.data?.docs[index]["rate"]}",style: const TextStyle(fontSize: 15),),
                                                                  RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 0),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  );
                                },
                                ),
                            )
                          ],
                        );
}),
),

 StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("hotels").snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children:  [
                                   Text("Most Visited",
                                  style: GoogleFonts.alata(fontSize: 18),
                                  ),
                                  Row(
                                    children:  [
                                      Text("See More",
                                     style: GoogleFonts.alata(fontSize: 18),
                                      ),
                                      const Icon(Icons.arrow_right)
                                    ],
                                  ),
                                ],
                              )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.25,
                              
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index){
                                  return Container(
                                                    //height: 200,
                                                    width: MediaQuery.of(context).size.width*0.7,
                                                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
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
                                                  child: InkWell(
                                                    onTap: () {
                                                      _controller.pause();
                                                      Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],img: snapshot.data?.docs[index]["image"],index: 1,)
                                                        )
                                                        );

                                                    },
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      children: [
                                                        ShaderMask(
                                                                shaderCallback: (rect) {
                                                                  return const LinearGradient(
                                                                    begin: Alignment.topCenter,
                                                                    end: Alignment.bottomCenter,
                                                                    colors: [
                                                                      Colors.transparent,
                                                                      Colors.black,
                                                                      Colors.black,
                                                                      Colors.transparent,
                                                                    ],
                                                                    stops: [0, 0, 0.6, 1],
                                                                    ).createShader(
                                                                      Rect.fromLTRB(0, 0, rect.width, rect.height)
                                                                    );
                                                                },
                                                                blendMode: BlendMode.dstIn,
                                                                child: ClipRRect(
                                                                borderRadius: BorderRadius.circular(7),
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
                                                                  ),
                                                                
                                                                ),
                                                              ),
                                                        Container(
                                                          margin: const EdgeInsets.fromLTRB(10, 0, 10, 5),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children:  [
                                                              Expanded(
                                                                child: Text(snapshot.data?.docs[index]["name"],
                                                                style: GoogleFonts.alata(fontSize: 15),
                                                                overflow: TextOverflow.ellipsis,maxLines: 1,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                   Text("${snapshot.data?.docs[index]["rate"]}",style: const TextStyle(fontSize: 15),),
                                                                  RatingBar(rating: snapshot.data?.docs[index]["rate"], ratingCount: 0),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  );
                                },
                                ),
                            )
                          ],
                        );
}),
),

                      ]
                      )
                      ),
    
                      ],
),
                  
),
],
);
}
}


