import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:app4/Screens/Registeration.dart';

class MyTextField extends StatelessWidget {
  
  const MyTextField({Key? key, 
    required this.controller,
    required this.hintText,
    required this.isPassword, 
    required this.isLogin,
    required this.type,
    required this.type2
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isLogin;
  final int type; // 0-->name | 1-->number | 2-->email | 3-->password
  final int type2;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: type < 2 ? null : controller,
        textInputAction: TextInputAction.next,
        obscureText: isPassword, 
        decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
      ),
      validator: (value)
      {
        if(type == 0)
        {
          if(value == "")
                {
                  return "please enter name";//
                }
                else
                {return null;}
        }
        else if (type == 1)
        {
          if(int.tryParse(value!) == null)
                {
                  return "please enter a valid number";
                }
                else
                {return null;}
        }
        else if (type == 2)
        {
          if(!EmailValidator.validate(value!))
                {
                  return "please enter a valid email";
                }
                else
                {return null;}
        }
        else if (type == 3)
        {
          if( value!.length < 6 )
                {
                  return "please enter at least 6 charcters";
                }
                else
                {return null;}
        }
        else
        {return null;}
      },
      onSaved:(newValue) {
        if(!isLogin)
        {enter(newValue!, type2);}
      },
      
      ),
    );
  }
}

