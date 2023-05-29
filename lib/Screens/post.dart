import 'dart:io';
import 'package:app4/Screens/Gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  List<File> _imageList = [];
  String _text = '';
  final picker = ImagePicker();
  final TextEditingController _textEditingController = TextEditingController();

  UploadTask? uploadTask;
  String ImageUrl = "";

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageList.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Student').where("Email",isEqualTo: user.email).snapshots(),
      builder: ((context, snap) {
      return (snap.connectionState == ConnectionState.waiting)
      ? Container()
      : SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6),
            child: Column(
              children:  [
                Row(children: [
                                  // const CircleAvatar(
                                  //   radius: 23,
                                  //   backgroundImage: NetworkImage(
                                  //       'https://th.bing.com/th/id/R.9106fd921b713b1c04ae897e2a11b2b2?rik=Xzc0%2bFe%2f1Vmgzg&pid=ImgRaw&r=0'),
                                  // ),
                                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: (snap.data?.docs[0]["image"] != "") ? Image.network(snap.data?.docs[0]["image"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("images/error1.gif",fit: BoxFit.cover,);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if(loadingProgress != null) 
                          {
                            return Image.asset("images/loading1.gif",fit: BoxFit.cover,);
                          }
                          return child;
                        },
                        ) : Image.asset('images/zzz.png',fit: BoxFit.cover,),  
                        ),
                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: TextField(
                                        controller: _textEditingController,
                                        decoration: InputDecoration(
                                          hintText: 'Write your post now!',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(30)),
                                        ),
                                        maxLines: null,
                                        onChanged: (value) {
                                        
                                            _text = value;
                                        
                                        },
                                      ),
                                    
                                  ),
                                  
                                  IconButton(
                                      color: Colors.green,
                                      iconSize: 35,
                                      icon: const Icon(Icons.filter),
                                      onPressed: getImage),
                                ]),
                              
                              const SizedBox(height: 10),
                            _imageList.isNotEmpty
                                ? SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _imageList.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 3),
                                          child: ClipRRect(
                                            borderRadius:BorderRadius.circular(10),
                                            child: Image.file(
                                              _imageList[index],
                                              fit: BoxFit.cover,
                                              
                                              width: 100,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 7),
                            InkWell(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                margin: const EdgeInsets.symmetric(horizontal: 0),
                                child:  Center(
                                    child: Text(
                                    'Post',
                                    style: GoogleFonts.rye(fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                              onTap: () {
                                  setState(() {
                                  // Reference referenceRoot = FirebaseStorage.instance.ref();
                                  // Reference referenceDirImages = referenceRoot.child('Posts_images');
                                  // String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
                                  // Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

                          //         try {
                          //   setState(() {
                          //     uploadTask = referenceImageToUpload.putFile(File("picked__File"));
                          //   });
                            
                          //   final _snapshot =  uploadTask!.whenComplete(() {});
                            

                          //   ImageUrl = _snapshot.ref.getDownloadURL();

                          //   setState(() {
                          //     uploadTask = null;
                          //   });

                          // }catch(error){
                          //   print(error);
                          // }

                                  try{
                                    FirebaseFirestore.instance.collection("Posts").add({
                                      "Email": user.email,
                                      "Text": _text,
                                      "images": _imageList,
                                      "Name": '${snap.data?.docs[0]["FirstName"]} ${snap.data?.docs[0]["LastName"]}',
                                      "image":snap.data?.docs[0]["image"],
                                      "Time" : DateTime.now().toString()
                                    }).then((DocumentReference doc) {
                                      FirebaseFirestore.instance.collection("Posts").doc(doc.id).update({
                                      "iid": doc.id,
                                    });
                                    });
                                  
                                  }on FirebaseAuthException catch (m){
                                    showDialog(context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                    title: Text(m.message.toString(),style: GoogleFonts.merriweather(),),
                                    actions: [
                                      Center(
                                        child: ElevatedButton(
                                          onPressed: (){
                                          Navigator.of(context).pop();
                                        }, child: Text("Okay",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.onSecondary),),
                                        style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
                                        ),
                                      )
                                    ],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                  );
                                  }
                                  );
                                  }
                                  _textEditingController.clear();
                                  _text ="";
                                  _imageList = [];
                                  }
                                  );
                                  
                                },
                            ),
                              
              ],
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Posts').snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : (snapshot.data!.docs.isEmpty)
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 241, 241, 241),
                                //borderRadius: BorderRadius.circular(7),
                                boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 6,
                                ),],
                               // image: DecorationImage(image: Image.network("src")),
                              ),
                            child: Column(
                                children: [
                                  const SizedBox(height: 16),
                                  Container(
                                    margin: const EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: (snapshot.data?.docs[index]["image"] != "") ? Image.network(snapshot.data?.docs[index]["image"],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("images/error1.gif",fit: BoxFit.cover,);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if(loadingProgress != null) 
                          {
                            return Image.asset("images/loading1.gif",fit: BoxFit.cover,);
                          }
                          return child;
                        },
                        ) : Image.asset('images/zzz.png',fit: BoxFit.cover,),
                        ),
                  ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${snapshot.data?.docs[index]["Name"]}',
                                                style: GoogleFonts.aBeeZee(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                snapshot.data?.docs[index]["Time"],
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        IconButton(onPressed: (){
                                        DocumentReference documentReference = FirebaseFirestore.instance.collection('Posts').doc(snapshot.data?.docs[index].id);
                                        documentReference.delete();
                                        }, icon: const Icon(Icons.cancel))
                                      ],
                                    ),
                                  ),
                                  
                                  snapshot.data?.docs[index]["Text"] == "" ?  const SizedBox(height: 10,) :
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data?.docs[index]["Text"],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          //fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  snapshot.data?.docs[index]["images"].isNotEmpty
                                      ? SizedBox(
                                          height: 360,
                                          child: GridView.builder(
                                            
                                            physics: const NeverScrollableScrollPhysics(),
                                            gridDelegate: snapshot.data?.docs[index]["images"].length == 1 ?   SliverQuiltedGridDelegate(crossAxisCount: 1,pattern: [const QuiltedGridTile(1, 1)])
                                            :  snapshot.data?.docs[index]["images"].length == 2 ?  SliverQuiltedGridDelegate(crossAxisCount: 2,pattern: [const QuiltedGridTile(2, 1),const QuiltedGridTile(2, 1)],mainAxisSpacing: 3,crossAxisSpacing: 3)
                                            :    snapshot.data?.docs[index]["images"].length == 3 ? SliverQuiltedGridDelegate(crossAxisCount: 2, pattern: [const QuiltedGridTile(2, 1),const QuiltedGridTile(1, 1),const QuiltedGridTile(1, 1)],mainAxisSpacing: 3,crossAxisSpacing: 3)
                                            : SliverQuiltedGridDelegate(crossAxisCount: 2,pattern: [const QuiltedGridTile(1, 1),const QuiltedGridTile(1, 1)],mainAxisSpacing: 3,crossAxisSpacing: 3)
                                            ,
                                            itemCount: snapshot.data?.docs[index]["images"].length,
                                            itemBuilder: (context, x) {
                                              if(x < 4)
                                              {
                                                if(x == 3)
                                                {
                                                  return InkWell(
                                                    onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context) => GalleryWidget(urlImages: snapshot.data?.docs[index]["images"],index: x) ) ),
                                                    child: Stack(
                                                      fit: StackFit.expand,
                                                      
                                                      children: [
                                                        Opacity(
                                                          opacity: snapshot.data?.docs[index]["images"].length > 4 ? 0.6 : 1.0,
                                                          child: ClipRRect(
                                                          //borderRadius:BorderRadius.circular(10),
                                                          child: Image.network(
                                                            snapshot.data?.docs[index]["images"][x],
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
                                                        snapshot.data?.docs[index]["images"].length > 4 ?  Center(
                                                          child: Text(
                                                                                        "+${snapshot.data?.docs[index]["images"].length-4}",
                                                                                        style: const TextStyle(
                                                                                            color: Colors.white,
                                                                                            fontSize: 40,
                                                                                            fontWeight: FontWeight.w600),
                                                                                      ),
                                                        ) : Container(),
                                                      ],
                                                    ),
                                                  );
                                                }
                                                else{
                                                  return InkWell(
                                                    onTap:() =>  Navigator.push(context,MaterialPageRoute(builder: (context) => GalleryWidget(urlImages: snapshot.data?.docs[index]["images"],index: x) ) ),
                                                    child: ClipRRect(
                                                    //borderRadius:BorderRadius.circular(10),
                                                    child: Image.network(
                                                      snapshot.data?.docs[index]["images"][x],
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
                                                  );
                                                }
                                                
                                              }
                                              else{return null;}
                                              
                                                
                                              
                                            },
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                          );
                            },
                          );
              },
            ),
          ),
        ],
      ),
    );
  
      }),
    );
    }
}