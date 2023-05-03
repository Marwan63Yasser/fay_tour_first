
import 'package:flutter/material.dart';
//import 'package:tour/screens/homepage.dart';
import 'package:app4/Screens/update_profile_screen.dart';
import 'package:app4/Widgets/ProfileMenuWidget.dart';
import 'package:app4/main.dart';

class profile_screen extends StatelessWidget {
  const profile_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isDark = true;
    return SingleChildScrollView(
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
                        child: const Image(
                          image: AssetImage('images/zzz.png'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text("hamada"),
              const SizedBox(height: 10),
              const Text("hm2456@fayoum.edu.eg"),
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
                      backgroundColor: Colors.green,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(("Edit profile"),
                      style: TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(height: 30),

              const ChangeTheme(),
                            const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Settings", icon: Icons.settings, onPress: () {}),
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
                  onPress: () {
                    showDialog(
                      builder: (context) => AlertDialog(
                        title: const Text('Do you want to exit this application?'),
                        content: const Text('We hate to see you leave...'),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              print("you choose no");
                              Navigator.of(context).pop(false);
                            },
                            child: const Text('No'),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                      context: context,
                    );
                  }),
            ],
          ),
        ),
      );
  }
}
