import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:tour/screens/homepage.dart';
import 'package:app4/Screens/update_profile_screen.dart';
import 'package:app4/Screens/settings.dart';
import 'package:app4/Widgets/ProfileMenuWidget.dart';
import 'package:google_fonts/google_fonts.dart';

class profile_screen extends StatelessWidget {
  profile_screen({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Student').where("Email",isEqualTo: user.email).snapshots(),
      builder: ((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: (snapshot.data?.docs[0]["image"] != "") ? Image.network(snapshot.data?.docs[0]["image"],
                         fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("images/error1.gif",fit: BoxFit.cover,);
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if(loadingProgress != null) 
                          {
                            return Image.asset("images/loading1.gif",fit: BoxFit.cover,);
                          }
                          return child;
                        },
                        ) : Image.asset('images/zzz.png',fit: BoxFit.cover,),  
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Hi, ""${snapshot.data?.docs[0]["FirstName"]} ${snapshot.data?.docs[0]["LastName"]}",style: GoogleFonts.aBeeZee()),
              const SizedBox(height: 10),
              Text(snapshot.data?.docs[0]["Email"],style: GoogleFonts.aBeeZee()),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UpdateProfileScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child:  Text(("Edit profile"),
                      style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary)),
                ),
              ),
              const SizedBox(height: 20),
                            const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Settings", icon: Icons.settings, onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const SSSettings()
                        ));
                  }),
              ProfileMenuWidget(
                  title: "Billing Details", icon: Icons.wallet, onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: Icons.verified_user_outlined,
                  onPress: () {}),
                  
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information", icon: Icons.info, onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.login_outlined,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {FirebaseAuth.instance.signOut();}),
            ],
          ),
        ),
      );
      }),
    );
  }
}
