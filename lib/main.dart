import 'package:app4/Theme/ThemeConstants.dart';
import 'package:app4/Theme/ThemeManager.dart';
import 'package:app4/Widgets/Auth.dart';
import 'package:app4/Widgets/BottomBar.dart';
import 'package:app4/Widgets/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

void main()  {
  runApp(const home());
} 

ThemeManager _themeManager = ThemeManager();

class home extends StatefulWidget{
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {

  @override
  void dispose()
  {
    _themeManager.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState()
  {
    _themeManager.addListener(themeListener);
    super.initState();
  }

  themeListener()
  {
    if(mounted)
    {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: LightMode,
      darkTheme: DarkMode,
      themeMode: _themeManager.themeMode,
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, db) 
        {
          if(db.connectionState == ConnectionState.done)
          {
            return StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: ((context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError)
                {
                  return const AlertDialog(
                    title: Text("ERROR"),
                  );
                } 
                else if(snapshot.hasData)
                {
                  
                  return const DefaultTabController(length: 3, child: BottomBar(select:0),);
                }
                else
                {
                  return const AUTH();
                }
              }));
          }
          else
          {
            return Load(color: Colors.black);
          }
          
        },
      ),
    );
  }
}


class ChangeTheme extends StatefulWidget {
  const ChangeTheme({Key? key}) : super(key: key);

  @override
  State<ChangeTheme> createState() => _ChangeThemeState();
}

class _ChangeThemeState extends State<ChangeTheme> {
  @override
  Widget build(BuildContext context) {
    return LiteRollingSwitch(
      animationDuration: const Duration(microseconds: 0),
      value: _themeManager.themeMode == ThemeMode.dark, 
      textOff: "Light",
      textOn: "Dark",
      //colorOff: Colors.grey,
      //colorOn: Colors.greenAccent,
      iconOff: Icons.light_mode,
      iconOn: Icons.dark_mode,
      width: 100,
      onDoubleTap: (){},
      onSwipe: (){},
      onTap: (){},
      onChanged: (newValue)
      {
        _themeManager.toggleTheme(newValue);
      }
    );

    
  }
}