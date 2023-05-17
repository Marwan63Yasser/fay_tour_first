import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app4/Widgets/BottomBar.dart';

class TourismScreen extends StatefulWidget {
  const TourismScreen({Key? key}) : super(key: key);

  @override
  _TourismScreenState createState() => _TourismScreenState();
}

class _TourismScreenState extends State<TourismScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _opacityAnimation;
  final user = FirebaseAuth.instance.currentUser!;
  String _selectedOption = '';
  String Selected = "";
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _opacityAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'images/backQuestions.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 50, bottom: 10, right: 15, left: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideTransition(
                            position: _offsetAnimation,
                            child: FadeTransition(
                              opacity: _opacityAnimation,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        'Select Tourism',
                                        style: GoogleFonts.aBeeZee(
                                          fontSize: 23,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    const Divider(
                                      color: Colors.black26,
                                      thickness: 1.9,
                                      indent: 40,
                                      endIndent: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _onOptionSelected(
                                            'Islamic antiquities');
                                        
                                          Selected = "Islamic";
                                      
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Islamic antiquities'
                                            ? MediaQuery.of(context).size.width*0.45
                                            : MediaQuery.of(context).size.width*0.40,
                                        height: _selectedOption ==
                                                'Islamic antiquities'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18, 
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://th.bing.com/th/id/R.3ed9f9cac4343a892c5a623e6b96e386?rik=40rBk65hhMaLXA&pid=ImgRaw&r=0',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Islamic antiquities')
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _onOptionSelected(
                                                'Coptic antiquities');
                                            
                                              Selected = "Coptic";
                                            
                                          },
                                          child: AnimatedContainer(
                                            duration:
                                                const Duration(seconds: 1),
                                            curve: Curves.easeInOut,
                                            width: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? MediaQuery.of(context).size.width*0.45
                                            : MediaQuery.of(context).size.width*0.40,
                                            height: _selectedOption ==
                                                    'Coptic antiquities'
                                                ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 3,
                                                  blurRadius: 7,
                                                  offset: const Offset(0, 3),
                                                ),
                                              ],
                                              image: const DecorationImage(
                                                image: NetworkImage(
                                                  'https://english.ahram.org.eg/Media/News/2022/1/9/42_2022-637773397396011486-601.jpg',
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        const Text('Coptic antiquities')
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _onOptionSelected(
                                            'Greek and Roman Antiquities');
                                        
                                          Selected = "Greek";
                                        
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? MediaQuery.of(context).size.width*0.45
                                            : MediaQuery.of(context).size.width*0.40,
                                        height: _selectedOption ==
                                                'Greek and Roman Antiquities'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://faytourimages.s3.amazonaws.com/image/86bde0a89c20966890af.jpeg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Greek and Roman')
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        _onOptionSelected('Pharaonic relics');
                                        
                                          Selected = "Pharaonic";
                                        
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(seconds: 1),
                                        curve: Curves.easeInOut,
                                        width: _selectedOption ==
                                                'Pharaonic relics'
                                            ? MediaQuery.of(context).size.width*0.45
                                            : MediaQuery.of(context).size.width*0.40,
                                        height: _selectedOption ==
                                                'Pharaonic relics'
                                            ? MediaQuery.of(context).size.height*0.23
                                            : MediaQuery.of(context).size.height*0.18,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                          image: const DecorationImage(
                                            image: NetworkImage(
                                              'https://faytourimages.s3.amazonaws.com/image/lohnenswerte-besichtigung.jpg',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Pharaonic relics')
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 8, bottom: 10),
                          //   child: InkWell(
                          //     child: Text("Skip"),
                          //     onTap: () {
                          //       print("d");
                          //     },
                          //   ),
                          // )

                          StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Student')
                                .where("Email", isEqualTo: user.email)
                                .snapshots(),
                            builder: ((context, snapshot) {
                              return (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 20),
                                      child: TextButton(
                                        onPressed: () {
                                          Selected == ""
                                              ? showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                        "Please Select",
                                                        style: GoogleFonts
                                                            .merriweather(),
                                                      ),
                                                      actions: [
                                                        Center(
                                                          child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              child: Text(
                                                                "Okay",
                                                                style: GoogleFonts.rye(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                              )),
                                                        )
                                                      ],
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                    );
                                                  })
                                            : {
                                              FirebaseFirestore.instance
                                                .collection("Student")
                                                .doc(snapshot.data?.docs[0]
                                                    ["iid"])
                                                .update({
                                                  "isFisrt": 0,
                                                  "fav": Selected
                                                  }),
                                                 Navigator.push(context,MaterialPageRoute(builder: (context) => const DefaultTabController(length: 3, child: BottomBar(select:1),),
                                                        )
                                                        )
                                                };
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 50),
                                          child: Text(
                                            "Next",
                                            style: GoogleFonts.rye(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 20),
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                      ),
                                    );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
