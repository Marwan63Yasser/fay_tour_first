import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:app4/main.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:google_fonts/google_fonts.dart';

class SSSettings extends StatelessWidget {
  const SSSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        elevation: 0,
        title:  Row(
          children:  [
            const Icon(Icons.settings),
            const SizedBox(width: 10,),
            Text("Settings",style: GoogleFonts.acme(fontSize: 23),),
          ],
        ),
        backgroundColor: Colors.transparent,
        
      ),
      body: FadeIn(
      child: ListView(
        children:  [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:  Card(
              color: Theme.of(context).colorScheme.secondary,
              child:  ListTile(
                leading: Text("App Theme",style: GoogleFonts.aBeeZee(fontSize: 19),),
                trailing: const ChangeTheme(),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:  Card(
              color: Theme.of(context).colorScheme.secondary,
              child: ListTile(
                leading:  Text("Language",style: GoogleFonts.aBeeZee(fontSize: 19),),
                trailing: LiteRollingSwitch(
                  onChanged:(newValue) {},
                  textSize: 13,
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {},
                  animationDuration: const Duration(microseconds: 100),
                  value: true, 
                  textOff: "Arabic",
                  textOn: "English",
                  //colorOff: Colors.grey,
                  //colorOn: Colors.greenAccent,
                  iconOff: Icons.language,
                  iconOn: Icons.language_outlined,
                  width: 100,
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:  Card(
              color: Theme.of(context).colorScheme.secondary,
              child: ListTile(
                leading:  Text("Price",style: GoogleFonts.aBeeZee(fontSize: 19),),
                trailing: LiteRollingSwitch(
                  onChanged:(newValue) {},
                  textSize: 13,
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {},
                  animationDuration: const Duration(microseconds: 100),
                  value: false, 
                  //textOff: "Off",
                  //textOn: "On",
                  //colorOff: Colors.grey,
                  //colorOn: Colors.greenAccent,
                  //iconOff: Icons.disabled_by_default,
                  //iconOn: Icons.all_out,
                  width: 100,
                ),
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(vertical: 2),
            child:  Card(
              color: Theme.of(context).colorScheme.secondary,
              child: ListTile(
                leading:  Text("Rating",style: GoogleFonts.aBeeZee(fontSize: 19),),
                trailing: LiteRollingSwitch(
                  onChanged:(newValue) {},
                  textSize: 13,
                  onDoubleTap: () {},
                  onSwipe: () {},
                  onTap: () {},
                  animationDuration: const Duration(microseconds: 100),
                  value: true, 
                  //textOff: "Off",
                  //textOn: "On",
                  //colorOff: Colors.grey,
                  //colorOn: Colors.greenAccent,
                  //iconOff: Icons.disabled_by_default,
                  //iconOn: Icons.all_out,
                  width: 100,
                ),
              ),
            ),
          ),
        ],
        ),
    ),
    );
  }
}