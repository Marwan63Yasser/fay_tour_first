import 'dart:math';
import 'package:app4/ResScreen.dart';
import 'package:app4/favScreen.dart';
import 'package:app4/LoginScreen.dart';
import 'package:app4/hotelsScreen.dart';
import 'package:app4/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BottomBar extends StatefulWidget {
  final int select;
  BottomBar({Key? key,required this.select}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

final user = FirebaseAuth.instance.currentUser!;

class _BottomBarState extends State<BottomBar> {
  String NAME = sss(user.email!);

  List<Widget> Screens = [EXPLORE(), FAV(), RESERVE(), PROFILE()];
  List<String> titles = ["Room Types List", "Favourites", "Reservations", "My Profile"];
  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.select;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[selected],style: TextStyle(fontFamily: 'KaushanScript',fontWeight: FontWeight.bold),),
        elevation: 15,
        foregroundColor: Colors.amber,
        backgroundColor: Colors.grey[800],
        centerTitle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
      body: Screens[selected],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() { 
            selected = value;
            
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber,
        type: BottomNavigationBarType.fixed,
        currentIndex: selected,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: "Explore",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded),
            label: "Favourites",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.padding_outlined),
            label: "Reservations",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.perm_identity_outlined),
            label: NAME,
          ),
        ],
      ),
    );
  }

}

String sss(String q)
  {
    String result = "";
    for(int i = 0;i<q.length;i++)
    {
      result += q[i];
      if(q[i] == '@')
      {
        break;
      }
    }
    return result;
  }