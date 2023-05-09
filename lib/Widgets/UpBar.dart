//This file is for the upbar of the hotels pages
import 'package:app4/Screens/AreaDescription.dart';
import 'package:flutter/material.dart';
import 'package:app4/Screens/HotelDescription.dart';
import 'package:app4/Data/CheckFavorite.dart';

class BAR extends StatelessWidget {
  String ro,img; 
  int index;
  BAR({Key? key, required this.ro,required this.index,required this.img}) : super(key: key) ;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height/3),
        child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(img,
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
                AppBar(
                backgroundColor: Colors.transparent,elevation: 0,
                leading: Container(
                  margin: const EdgeInsets.fromLTRB(7, 7, 0, 0),
                  child: FloatingActionButton(
                  elevation: 0,
                  onPressed: () {Navigator.pop(context);},
                  child: const Icon(Icons.arrow_back_rounded,),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  
                ),
              actions: [
                checkFav(ro: ro, image: img, PlaceType: index),
              ],
                ),          
              ],
            )
        ),
        bottomNavigationBar: (index == 0) ? Desc(ro: ro) : HOTEL(ro: ro),
          );
  }
}