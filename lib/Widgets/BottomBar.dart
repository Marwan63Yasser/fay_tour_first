//Bottom bar file --> browse the main pages
import 'package:app4/Screens/Plans.dart';
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

  List<Widget> Screens = [profile_screen(), const FAV() ,const EXPLORE(), const ZoomableImage(),];
  List<String> titles = ["My Profile", "Favourites","FayTour", "Plans"];
  int selected = 0;
  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
          appBar: AppBar(
            title: Text(titles[selected],style: const TextStyle(fontFamily: 'KaushanScript',fontWeight: FontWeight.bold,fontSize: 25),),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
            elevation: 0,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            centerTitle: true,
            leading: selected == 2 ? Container(
                margin: const EdgeInsets.only(left: 8),
                child: Hero(
                  child: Image.asset("images/aaa.png",
                
                  ),
                tag: "logo",
                ),
                )
             : null,
            actions: selected == 2 ? [
              Container(
                margin: const EdgeInsets.fromLTRB(0, 5, 8, 5),
                padding: const EdgeInsets.all(10),
                decoration:  BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6
                    )
                  ],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26,
                  ),
                ),
              ),
            ] : null,
            ),
          body: Screens[selected],
          bottomNavigationBar: CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 200),
          color: Theme.of(context).colorScheme.tertiaryContainer,
          
          items: const [
            Icon(
              Icons.person_outlined,
              size: 25,
            ),
            Icon(
              Icons.favorite_outline,
              size: 25,
            ),
            Icon(
              Icons.home,
              size: 25,
            ),
            Icon(
              Icons.padding_outlined,
              size: 25,
            ),
          ],
          onTap: (value) {
            setState(() {
              selected = value;
            });
          },
          index: selected,
        )
    );
  }

}



////////////////////////////Old Design//////////////////////////////////////////////
// CurvedNavigationBar(
//             onTap: (value) {
//               setState(() { 
//                 selected = value;
//               });
//             },
//             animationDuration: const Duration(milliseconds: 200),
//             color: Colors.green,
//             backgroundColor: Colors.transparent,
//             buttonBackgroundColor: Colors.green,//Theme.of(context).colorScheme.tertiary,
//             index: selected,
//             items:  [
//             Icon(Icons.explore_outlined,color: Theme.of(context).colorScheme.secondary,),
//             Icon(Icons.favorite_border_rounded,color: Theme.of(context).colorScheme.secondary,),
//             Icon(Icons.padding_outlined,color: Theme.of(context).colorScheme.secondary,),
//             Icon(Icons.perm_identity_outlined,color: Theme.of(context).colorScheme.secondary,),
//             ],
//           ),