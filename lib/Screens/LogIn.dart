//Login Page
import 'package:app4/Data/SignIn.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:app4/Widgets/TextField.dart';
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
      signIn(context, emailContoller, passwordContoller);
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

      body: 
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: SafeArea(
              child:
          
                  Form(
                  key: sign1,  
                  child: ListView(
                    children: [
    
                      Hero(tag: 'logo', child: Container(
                  margin: const EdgeInsets.fromLTRB(0,80,0,25),
                  height: 200,
                  width: 200,
                  child: Image.asset('images/aaa.png'),
                    ),
                    ),
    
                  MyTextField(controller: emailContoller, hintText: "Email", isPassword: false, isLogin: true, type: 2, type2: 0),
                  MyTextField(controller: passwordContoller, hintText: "Password", isPassword: true, isLogin: true, type: 3, type2: 0),
                      
                  Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: SizedBox(
                          height: 55,
                          width: 320,
                          child: TextButton(
                            onPressed: (){
                              saveForm();
                            }, child: Text("Sign In",style: GoogleFonts.rye(fontSize: 16,color: Theme.of(context).colorScheme.onSecondary),),
                            style: TextButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            ),
                            ),
                        ),
                      ),


                      Center(
                        child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: RichText(
                              text: TextSpan(
                                
                                text: 'Not a member?  ',
                                
                                children: [
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                    text: 'Register Now',
                                    style: GoogleFonts.merriweather(color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ],
                                style: GoogleFonts.merriweather(color: Theme.of(context).colorScheme.onPrimary),
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
}