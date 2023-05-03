import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future signIn(final context, TextEditingController emailContoller, TextEditingController passwordContoller) async{

    try {await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailContoller.text.trim(), 
      password: passwordContoller.text.trim()
      ); 
    }
    on FirebaseAuthException catch(e){
      showDialog(context: context, 
    barrierDismissible: false, 
    builder: (context) {
      return AlertDialog(
      title: Text(e.message.toString(),style: GoogleFonts.merriweather(),),
      actions: [
        Center(
          child: ElevatedButton(
            onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Okay",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.onSecondary),),
          style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.secondary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
          ),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    }
    );
    }

  }
