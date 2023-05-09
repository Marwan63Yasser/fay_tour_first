import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app4/Data/UserDataTemplate.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);



  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreen();
}

USER temp = USER();

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  String picked__File = "";
  File? _profileImageFile;
  String ImageUrl = "";
  bool _hasChangedProfileImage = false;
  late String _profileImagePath;

  UploadTask? uploadTask;

  final user = FirebaseAuth.instance.currentUser!;

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Student').where("Email",isEqualTo: user.email).snapshots(),
      builder:((context, snapshot) {
        return (snapshot.connectionState == ConnectionState.waiting)
                ? Container()
                : Scaffold(
     backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Row(
          children: [
            const Icon(Icons.edit),
            const SizedBox(width: 10,),
            Text("Edit Profile",style: GoogleFonts.acme(fontSize: 23),),
          ],
        ),
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
                            : (snapshot.data?.docs[0]["image"] != "") ? Image.network(snapshot.data?.docs[0]["image"],
                         fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset("images/error1.gif");
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if(loadingProgress != null) 
                          {
                            return Image.asset("images/loading1.gif");
                          }
                          return child;
                        },
                        ) : Image.asset('images/zzz.png',fit: BoxFit.cover,),
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
                            color: Theme.of(context).colorScheme.primary),
                        child: InkWell(
                          child:  Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.secondary,
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
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("First Name"),
                          prefixIcon: Icon(Icons.person)),
                          validator: (value) {
                            if(value == "")
                {
                  return "please enter name";//
                }
                else
                {return null;}
                          },
                    onSaved: (newValue) {
                      temp.FirstName = newValue!; 
                    },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Last Name"),
                          prefixIcon: Icon(Icons.person)),
                          validator: (value) {
                            if(value == "")
                {
                  return "please enter name";//
                }
                else
                {return null;}
                          },
                      onSaved: (newValue) {
                      temp.LastName = newValue!; 
                    },
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      decoration: const InputDecoration(
                          label: Text("Phone Number"),
                          prefixIcon: Icon(Icons.phone)),
                          validator: (value) {
                            if(int.tryParse(value!) == null)
                {
                  return "please enter a valid number";
                }
                else
                {return null;}
                          },
                          onSaved: (newValue) {
                      temp.Mobile = newValue!; 
                    },
                    ),
                //     const SizedBox(height: 30),
                //     TextFormField(
                //       decoration: const InputDecoration(
                //           label: Text("Email"),
                //           prefixIcon: Icon(Icons.email)),
                //           validator: (value) {
                //             if(!EmailValidator.validate(value!))
                // {
                //   return "please enter a valid email";
                // }
                // else
                // {return null;}
                //           },
                //           onSaved: (newValue) {
                //       temp.Email = newValue!; 
                //     },
                //     ),
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
                      validator: (value) {
                        if( value!.length < 6 )
                {
                  return "please enter at least 6 charcters";
                }
                else
                {return null;}
                      },
                    onSaved: (newValue) {
                      temp.Password = newValue!; 
                    },
                    ),
                    const SizedBox(height: 50),

                    // -- Form Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {

                          final isValid = form.currentState!.validate();
                          if(!isValid) return;

                          form.currentState?.save();

                          Reference referenceRoot = FirebaseStorage.instance.ref();
                          Reference referenceDirImages = referenceRoot.child('User_images');
                          String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
                          Reference referenceImageToUpload = referenceDirImages.child(uniqueName);

                          try{
                            setState(() {
                              uploadTask = referenceImageToUpload.putFile(File(picked__File));
                            });
                            
                            final snapshot =  await uploadTask!.whenComplete(() {}); 
                            
                            ImageUrl = await snapshot.ref.getDownloadURL();

                            setState(() {
                              uploadTask = null;
                            });

                          }catch(error){
                            print(error);
                          }

                          
                          FirebaseAuth.instance.currentUser!.updatePassword(temp.Password);
                          //FirebaseAuth.instance.currentUser!.updateEmail(temp.Email);

                          if(ImageUrl != "")
                          {
                            
                            FirebaseFirestore.instance.collection("Student").doc(snapshot.data?.docs[0]["iid"]).update(
                            {
                              'FirstName': temp.FirstName,
                              'LastName': temp.LastName,
                              'Mobile': temp.Mobile,
                              'Password': temp.Password,
                              'image': ImageUrl
                            }
                          );
                          }
                          else
                          {
                            FirebaseFirestore.instance.collection("Student").doc(snapshot.data?.docs[0]["iid"]).update(
                            {
                              'FirstName': temp.FirstName,
                              'LastName': temp.LastName,
                              'Mobile': temp.Mobile,
                              'Password': temp.Password
                            }
                          );
                          }
                           

                        Navigator.pop(context);
                          
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.primary,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child:  Text("Edit Profile",
                            style: GoogleFonts.rye(color: Theme.of(context).colorScheme.secondary)),
                      ),
                    ),
                    const SizedBox(height: 15),

                    _profileImageFile != null ? BuildProcess() : Container(),
                    // -- Created Date and Delete Button
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
      }),
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
        picked__File = pickedFile.path;
        _hasChangedProfileImage = true;
      });
    }
  }

  Widget BuildProcess() => StreamBuilder<TaskSnapshot>(
    stream: uploadTask?.snapshotEvents,
    builder:(context, snapshot) {
      if(snapshot.hasData)
      {
        final data = snapshot.data!;
        double progress = data.bytesTransferred / data.totalBytes;
        return SizedBox(
          height: 35,
          child: Stack(
            fit: StackFit.expand,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey,
                color: Colors.green,
              ),
              Center(
                child: Text(
                  'Loading:${(100*progress).roundToDouble()}%',
                  style:  TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ],
          ),
        );
      }
      else
      {
        return Container();
      }
    },
  );

}

