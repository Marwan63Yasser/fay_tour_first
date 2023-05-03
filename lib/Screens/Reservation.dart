//The initial page for plans of the user
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class RESERVE extends StatelessWidget {
  const RESERVE({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) {
        return  FadeIn(
      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 17,vertical: 12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onTertiary,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                        color: Colors.grey,//Theme.of(context).colorScheme.primary,
                        blurRadius:8, 
                      ),            
                      ]
                    ),
                    child:ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset('images/plan1.jpeg'))

),
      // Optional paramaters
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
      );
      },
    );
  }
}


