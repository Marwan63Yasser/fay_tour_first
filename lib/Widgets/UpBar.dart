//This file is for the upbar of the hotels pages
import 'package:app4/Screens/AreaDescription.dart';
import 'package:flutter/material.dart';
import 'package:app4/Screens/HotelDescription.dart';

class BAR extends StatelessWidget {
  String ro,img; 
  int index;
  BAR({Key? key, required this.ro,required this.index,required this.img}) : super(key: key) ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/3),
        child: Container(
          decoration: BoxDecoration(image: DecorationImage( image: NetworkImage(img),fit: BoxFit.fill)),
          child: AppBar(backgroundColor: Colors.transparent,elevation: 0,
          leading: FloatingActionButton(
                onPressed: () {Navigator.pop(context);},
                child: const Icon(Icons.arrow_back_rounded,),
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
          ),
        ),
        ),
        bottomNavigationBar: (index == 0) ? Desc(ro: ro) : HOTEL(ro: ro),
          );
  }
}