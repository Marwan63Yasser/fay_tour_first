import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:tour/screens/homepage.dart';
import 'package:app4/Screens/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
// class UpdateProfileScreen extends StatelessWidget {

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);



  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  File? _profileImageFile;
  bool _hasChangedProfileImage = false;
  late String _profileImagePath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
           Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        title: const Text("Edit Profile",
            style: TextStyle(fontSize: 25, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              // -- IMAGE with ICON
              Container(
                child: Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: _profileImageFile != null
                            ? Image.file(_profileImageFile!, fit: BoxFit.cover)
                            : Image.asset('images/kkk.jpg',
                                fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.green),
                        child: InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 20,
                          ),
                          onTap: _showImagePicker,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),

              // -- Form Fields
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Full Name"),
                          prefixIcon: Icon(Icons.person)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Email"), prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Phone Number"),
                          prefixIcon: Icon(Icons.phone)),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        label: const Text("Password"),
                        prefixIcon: const Icon(Icons.fingerprint),
                        suffixIcon: IconButton(
                            icon: const Icon(Icons.remove_red_eye),
                            onPressed: () {}),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("Edit Profile",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(height: 50),

                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePicker() async {
    final pickedFile = await showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () async {
                  final pickedFile =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  Navigator.pop(context, pickedFile);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () async {
                  final pickedFile =
                      // ignore: deprecated_member_use
                      await ImagePicker().getImage(source: ImageSource.camera);
                  Navigator.pop(context, pickedFile);
                },
              ),
            ],
          ),
        );
      },
    );
    if (pickedFile != null) {
      setState(() {
        _profileImageFile = File(pickedFile.path);
        _hasChangedProfileImage = true;
      });
    }
  }
}
