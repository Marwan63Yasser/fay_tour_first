import 'package:app4/Auth.dart';
import 'package:app4/BottomBar.dart';
import 'package:app4/LogInScreen.dart';
import 'package:app4/RegScreen.dart';
import 'package:app4/descScreen.dart';
import 'package:app4/loader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  {
  runApp(home());
} 

class home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
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
                  return Center(child: CircularProgressIndicator());
                }
                else if(snapshot.hasError)
                {
                  return AlertDialog(
                    title: Text("ERROR"),
                  );
                } 
                else if(snapshot.hasData)
                {
                  return DefaultTabController(length: 4, child: BottomBar(select: 0),);
                }
                else
                {
                  return AUTH();
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

