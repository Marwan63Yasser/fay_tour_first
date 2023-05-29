//Bottom bar file --> browse the main pages
import 'package:app4/Screens/Plans.dart';
import 'package:app4/Screens/profile_screen.dart';
import 'package:app4/Screens/Favourites.dart';
import 'package:app4/Screens/AreasList.dart';
import 'package:app4/Screens/post.dart';
import 'package:app4/Screens/search.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomBar extends StatefulWidget { 
  final int select;
  const BottomBar({Key? key,required this.select}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
} 

class _BottomBarState extends State<BottomBar> {
  final TextEditingController _searchController = TextEditingController();
  bool search = false;
  List<Widget> screens = [profile_screen(), const EXPLORE() ,const HomePage(),const FAV(), const ZoomableImage(),];
  List<String> titles = ["My Profile", "FayTour","Post to FayTour","Favorites", "Plans"];
  int selected = 0;
  String _text = '';
  int search_counter = 0;
  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
          appBar: search ? AppBar(
            title: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                  //prefixIcon: Icon(Icons.search)
                ),
                style: const TextStyle(color: Colors.black),
                onChanged: (value) {
                
                
                setState(() {
                      search_counter = 0;
                      _text = value;
                    });
                
                },
              ),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
            elevation: 0,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                setState(() {
                  _searchController.clear();
                  _text = "";
                  search = false;
                });
              },
              child: const Icon(Icons.arrow_back),
            ),
            )
          : AppBar(
            title: Text(titles[selected],style: const TextStyle(fontFamily: 'KaushanScript',fontWeight: FontWeight.bold,fontSize: 25),),
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            backgroundColor: Colors.transparent,
            elevation: 0,
            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            centerTitle: true,
            leading: selected == 1 ? Container(
                margin: const EdgeInsets.only(left: 8),
                child: Hero(
                  child: Image.asset("images/aaa.png",
                
                  ),
                tag: "logo",
                ),
                )
            : null,
            actions: selected == 1 ? [
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
                  //Navigator.push(context,MaterialPageRoute(builder: (context) => const SEARCH(),));
                  setState(() {
                    search =true;
                  });
                  },
                  child: const Icon(
                    Icons.search,
                    size: 26,
                  ),
                ),
              ),
            ] : null,
            ),
          body: search ?  SEARCH(search_ketword: _text,search_count: search_counter,) : screens[selected],
          bottomNavigationBar: search ? null : CurvedNavigationBar(
          height: 65,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 200),
          color: Theme.of(context).colorScheme.tertiaryContainer,
          
          items:  [
            const Icon(
              Icons.person_outlined,
              size: 25,
            ),
      
            const Icon(
              Icons.home,
              size: 25,
            ),
            Icon(
              selected == 2 ? Icons.add_circle :Icons.add_circle_outline,
              size: 25,
            ),
            const Icon(
              Icons.favorite_outline,
              size: 25,
            ),
            const Icon(
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