//Registeration File
import 'package:app4/Data/SignUp.dart';
import 'package:app4/Data/UserDataTemplate.dart';
import 'package:app4/Widgets/TextField.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


USER temp = USER();

class reg extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  
  const reg({Key? key,
  required this.onClickedSignUp,
  }) : super(key: key);

  @override
  State<reg> createState() => _regState();
}

class _regState extends State<reg> {

  final ccontoller = TextEditingController();

  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();
  final form = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),  
        child: SafeArea(
          child: Form(
            key: form,
            child: ListView(children: [
            Hero(tag: 'logo', child: Container(
              margin: const EdgeInsets.fromLTRB(0,40,0,10), 
              height: 200,
              child: Image.asset('images/aaa.png'),
            ),
            ),

            MyTextField(controller: ccontoller, hintText: "Fisrt Name", isPassword: false, isLogin: false, type: 0, type2: 0),
            MyTextField(controller: ccontoller, hintText: "Last Name", isPassword: false, isLogin: false, type: 0, type2: 1),
            MyTextField(controller: ccontoller, hintText: "Mobile Number", isPassword: false, isLogin: false, type: 1, type2: 4),
            MyTextField(controller: emailContoller, hintText: "Email", isPassword: false, isLogin: false, type: 2, type2: 2),
            MyTextField(controller: passwordContoller, hintText: "Password", isPassword: true, isLogin: false, type: 3, type2: 3),
          
            Container(
                  margin: const EdgeInsets.symmetric(vertical: 25),
                  child: SizedBox(
                    height: 45,
                    width: 150,
                    child: TextButton(
                      onPressed: (){
                        signUp(context, form, emailContoller, passwordContoller, temp);
                      }, child: Text("Register",style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary,fontSize: 14),),
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))
                      ),
                      ),
                  ),
                ),

                Center(
                  child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: RichText(
                            text: TextSpan(
                              text: 'Already member?  ',
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                  text: 'Log In',
                                  style: GoogleFonts.merriweather(color: Theme.of(context).colorScheme.primary),
                                )
                              ],
                              style: GoogleFonts.merriweather(color: Theme.of(context).colorScheme.onPrimary),
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


}

enter(String val,int type)
{
  if(type == 0) {
    temp.FirstName = val;
  } else if(type == 1) {
    temp.LastName = val;
  } else if (type == 2) {
    temp.Email = val;
  } else if (type == 3) {
    temp.Password = val;
  } else {
    temp.Mobile = val;
  }
}