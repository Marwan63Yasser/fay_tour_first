
import 'package:app4/RegScreen.dart';
import 'package:app4/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LOG extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LOG({Key? key,
  required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<LOG> createState() => _LOGState();
}

class _LOGState extends State<LOG> {
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  final sign1 = GlobalKey<FormState>();
  saveForm() async
  {
    if(sign1.currentState?.validate() == true)
    {
      sign1.currentState?.save();
      signIn();
    }
  }

  @override
  void dispose()
  {
    emailContoller.dispose();
    passwordContoller.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SafeArea(
              child:
          
                  Form(
                  key: sign1,  
                  child: ListView(
                    children: [
    
                      Hero(tag: 'logo', child: Container(
                  margin: EdgeInsets.fromLTRB(0,80,0,0),
                  height: 200,
                  child: Image.asset('images/ttt.png'),
                    ),
                    ),
    
                      Container(
                        margin: EdgeInsets.fromLTRB(0,40,0,20),
                        child: TextFormField(
                          controller: emailContoller,
                          keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),
                      onSaved: (newValue) {
                       
                      },
                    validator: (value) {
                      if(value == "")
                      {
                        return "please enter a valid email";
                      }
                      else
                      {return null;}
                    },
                        ),
                      ),
    
                      Container(
                    margin: EdgeInsets.fromLTRB(0,0,0,20),
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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: 55,
                          width: 320,
                          child: TextButton(
                            onPressed: (){
                              saveForm();
                            }, child: Text("Sign In",style: GoogleFonts.rye(color: Colors.black,fontSize: 16),),
                            style: TextButton.styleFrom(backgroundColor: Colors.amber,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                            ),
                            ),
                        ),
                      ),


                      Center(
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: RichText(
                              text: TextSpan(
                                text: 'Not a member?  ',
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                    text: 'Register Now',
                                    style: GoogleFonts.merriweather(color: Colors.blue),
                                  )
                                ],
                                style: GoogleFonts.merriweather(),
                              )
                              )
                          ),
                      ),
               ],
                  
              ),
                  
            ),
    
  
        ),
      ),
    );
  }

  Future signIn() async{

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