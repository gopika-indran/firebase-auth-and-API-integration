import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mock/login.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  TextEditingController namecontroller = TextEditingController();
  File? imagefile;
  FirebaseAuth auth = FirebaseAuth.instance;
  late User? _currentuser;
  String name = "";
  String email = "";
  String number = "";
  bool isuploading = false;
  String imageurl = "";

  void getdetails() async {
    _currentuser = FirebaseAuth.instance.currentUser;
    if (_currentuser != null) {
      fetchdetails();
    }
  }

  void fetchdetails() async {
    DocumentSnapshot usersnapshort = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(_currentuser!.uid)
        .get();
    setState(() {
      name = usersnapshort["name"];
      email = usersnapshort["email"];
      number = usersnapshort["number"];
      imageurl = usersnapshort["url"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdetails();
    fetchdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 181, 220, 239),
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text("profile")),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 120),
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                      "https://thumbs.dreamstime.com/b/default-avatar-profile-flat-icon-social-media-user-vector-portrait-unknown-human-image-default-avatar-profile-flat-icon-184330869.jpg"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(name),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(email),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "phone number",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(number),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Loginpage(),
                        ));
                  },
                  child: const Text("LOG OUT YOUR ACCOUNT")),
              TextButton(
                  onPressed: () async {
                    try {
                      _currentuser = FirebaseAuth.instance.currentUser;
                      await _currentuser!.delete();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Loginpage(),
                          ));
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text(
                    "Delect your account",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
