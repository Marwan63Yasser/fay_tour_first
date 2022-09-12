import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class USER{
  String FirstName="";
  String LastName="";
  String Email="";
  String Mobile="";
  String Password="";
}

class reg extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const reg({Key? key,
  required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {

  USER user = USER();
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(backgroundColor: Colors.grey[850],foregroundColor: Colors.amber,elevation: 0,),
      //backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18), 
        child: SafeArea(
          child: Form(
            key: form,
            child: ListView(children: [
            Hero(tag: 'logo', child: Container(
              margin: EdgeInsets.fromLTRB(0,40,0,10),
              height: 200,
              child: Image.asset('images/ttt.png'),
            ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "First Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                ),
                onSaved: (newValue) {
                  user.FirstName = newValue!;
                },
              validator: (value) {
                if(value == "")
                {
                  return "please enter name";
                }
                else
                {return null;}
              },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Last Name",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                ),
                onSaved: (newValue) {
                  user.LastName = newValue!;
                },

                validator: (value) {
                if(value == "")
                {
                  return "please enter name";
                }
                else
                {return null;}
              },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Mobile Number",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                ),
                onSaved: (newValue) {
                  user.Mobile = newValue!;
                },

                validator: (value) {
                if(int.tryParse(value!) == null)
                {
                  return "please enter a valid number";
                }
                else
                {return null;}
              },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                controller: emailContoller,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                ),
                onSaved: (newValue) {
                  user.Email = newValue!;
                },

                validator: (value) {
                if(!EmailValidator.validate(value!))
                {
                  return "please enter a valid email";
                }
                else
                {return null;}
              },
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              child: TextFormField(
                controller: passwordContoller,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                ),
                onSaved: (newValue) {
                  user.Password = newValue!;
                },

                validator: (value) {
                if( value!.length < 6 )
                {
                  return "please enter at least 6 charcters";
                }
                else
                {return null;}
              },
              ),
            ),
          
            Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: TextButton(
                      onPressed: (){
                        signUp();
                      }, child: Text("Register",style: GoogleFonts.rye(color: Colors.black,fontSize: 14),),
                      style: TextButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                      ),
                      ),
                  ),
                ),

                Center(
                  child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already member?  ',
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                  text: 'Log In',
                                  style: GoogleFonts.merriweather(color: Colors.blue),
                                )
                              ],
                              style: GoogleFonts.merriweather(),
                            )
                            )
                        ),
                ),
          ]),
          
          ),
        ),
      ),
    );
  }

  Future signUp() async{

    final isValid = form.currentState!.validate();
    if(!isValid) return;

    form.currentState?.save();

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailContoller.text.trim(), 
        password: passwordContoller.text.trim(),
        );
      FirebaseFirestore.instance.collection("Student").add({
        "FirstName": user.FirstName,
          "LastName": user.LastName,
          "Mobile": user.Mobile,
          "Email": user.Email,
          "Password": user.Password
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
          }, child: Text("Okay",style: GoogleFonts.rye(color: Colors.black),),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),)
          ),
        )
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
    }
    );
    }

  }
}