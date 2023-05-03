//Bottom bar file --> browse the main pages
import 'package:app4/Screens/Reservation.dart';
import 'package:app4/Screens/profile_screen.dart';
import 'package:app4/Screens/Favourites.dart';
import 'package:app4/Screens/AreasList.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomBar extends StatefulWidget { 
  final int select;
  const BottomBar({Key? key,required this.select}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
} 

class _BottomBarState extends State<BottomBar> {

  List<Widget> Screens = [const EXPLORE(), const FAV() ,const RESERVE(), const profile_screen()];
  List<String> titles = ["Torism Areas", "Favourites","Plans", "My Profile"];
  int selected = 0;
  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 21, 21, 21),
          appBar: AppBar(
            title: Text(titles[selected],style: const TextStyle(fontFamily: 'KaushanScript',fontWeight: FontWeight.bold,fontSize: 25),),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            centerTitle: true,
            ),
          body: Screens[selected],
          bottomNavigationBar: CurvedNavigationBar(
            onTap: (value) {
              setState(() { 
                selected = value;
              });
            },
            
            color: Colors.green,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.green,//Theme.of(context).colorScheme.tertiary,
            index: selected,
            items:  [
            Icon(Icons.explore_outlined,color: Theme.of(context).colorScheme.secondary,),
            Icon(Icons.favorite_border_rounded,color: Theme.of(context).colorScheme.secondary,),
            Icon(Icons.padding_outlined,color: Theme.of(context).colorScheme.secondary,),
            Icon(Icons.perm_identity_outlined,color: Theme.of(context).colorScheme.secondary,),
            ],
          ),
    );
  }

}
