import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app4/Widgets/UpBar.dart';


class SEARCH extends StatefulWidget {
  String search_ketword;
  int search_count;
  SEARCH({Key? key, required this.search_ketword,required this.search_count}) : super(key: key);

  @override
  State<SEARCH> createState() => _SEARCHState();
}

class _SEARCHState extends State<SEARCH> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Areas').snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (widget.search_ketword == "") ? Center(child: Text("Please Write Something!",style: GoogleFonts.pressStart2p(fontSize: 13,color: Theme.of(context).colorScheme.primary),),)
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      var data = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                      if(data['desc'].toString().toLowerCase().contains(widget.search_ketword.toLowerCase()))
                      {
                        return InkWell(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["name"],index: 0,img: snapshot.data?.docs[index]["images"][0])));

                            },
                            child: Container(
                              height: 200,
                              margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 7),
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
                                              stops: [0, 0.0, 0.8, 1],
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
                                            return Image.asset("images/error1.gif");
                                          },
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if(loadingProgress != null)
                                            {
                                              return Image.asset("images/loading5.gif");
                                            }
                                            return child;
                                          },
                                          ),
                                          ),
                                        ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(snapshot.data?.docs[index]["name"],style: GoogleFonts.merriweather(fontSize: 18,color: Theme.of(context).colorScheme.onPrimary,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                                          
                                        ],
                                      ),
                                  ],
                                  ),
                                  

                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(7),
                                boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                ),],
                               // image: DecorationImage(image: Image.network("src")),
                              ),
                                ),
                          );
                      }
                      else
                      {
                        if(widget.search_count == snapshot.data!.docs.length-1)
                        {
                          return Container(
                            margin:  EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
                            child: Center(child: Text("Not Found!",style: GoogleFonts.pressStart2p(fontSize: 25,color: Theme.of(context).colorScheme.primary),),));
                          
                        }
                        else
                        {
                          widget.search_count++;
                          return Container();
                        }
                        
                      }
                      
                    },
        );
      }),
    );
    }
}