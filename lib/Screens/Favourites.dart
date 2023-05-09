//This file is for viewing the list of the favorites of the user
import 'package:app4/Widgets/UpBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


class FAV extends StatefulWidget {
  const FAV({Key? key}) : super(key: key);
 
  @override 
  State<FAV> createState() => _FAVState();
} 

class _FAVState extends State<FAV> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Favourite').where("Email",isEqualTo: user.email).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (snapshot.data!.docs.isEmpty)
                ?Center(child: Text("Nothing Yet",style: GoogleFonts.pressStart2p(fontSize: 25,color: Theme.of(context).colorScheme.primary),),)
                :ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index){
                      return 
                          InkWell(
                            onTap: () {
                              if(snapshot.data?.docs[index]["type"] == "area")
                              {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["Fav"],index: 0,img: snapshot.data?.docs[index]["image"])));
                              }
                              else
                              {
                                Navigator.push(context,MaterialPageRoute(builder: (context) => BAR(ro: snapshot.data?.docs[index]["Fav"],index: 1,img: snapshot.data?.docs[index]["image"])));
                              }
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
                                              stops: [0, 0.2, 0.8, 1],
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          IconButton(onPressed: () {},
                                          icon:  const Icon(Icons.favorite,color: Colors.red,),
                                          ),
                                          IconButton(onPressed: () async {
                                  DocumentReference documentReference = FirebaseFirestore.instance.collection('Favourite').doc(snapshot.data?.docs[index].id);
                                  await documentReference.delete();                                  
                                },
                                icon:  Icon(Icons.cancel,color: Theme.of(context).colorScheme.onPrimary,),
                                ),
                              
                                        ],
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          (snapshot.data?.docs[index]["type"] == "area") 
                                          ? Text(snapshot.data?.docs[index]["Fav"],style: GoogleFonts.merriweather(fontSize: 18,color: Theme.of(context).colorScheme.onPrimary,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                                          
                                          : Text(snapshot.data?.docs[index]["Fav"]+" Hotel",style: GoogleFonts.merriweather(fontSize: 18,color: Theme.of(context).colorScheme.onPrimary,),overflow: TextOverflow.ellipsis,maxLines: 1,)
                                          
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
                      
                    },
        );
      }),
    );
  }
}
