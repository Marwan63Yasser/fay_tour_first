import 'package:app4/Data/UserDataTemplate.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';


Future signUp(final context,final formKey, TextEditingController emailContoller, TextEditingController passwordContoller, USER temp) async{

  final isValid = formKey.currentState!.validate();
  if(!isValid) return;
 
  formKey.currentState?.save();

  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailContoller.text.trim(), 
      password: passwordContoller.text.trim(),
      );
    FirebaseFirestore.instance.collection("Student").add({
      "FirstName": temp.FirstName,
        "LastName": temp.LastName,
        "Mobile": temp.Mobile,
        "Email": temp.Email,
        "Password": temp.Password
    });
    
  }on FirebaseAuthException catch (m){
    showDialog(context: context,
  barrierDismissible: false, 
  builder: (context) {
    return AlertDialog(
    title: Text(m.message.toString(),style: GoogleFonts.merriweather(),),
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