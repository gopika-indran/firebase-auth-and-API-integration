import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mock/login.dart';
import 'package:mock/textfformieldcust.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final String urllink =
      "https://i.pinimg.com/736x/c0/27/be/c027bec07c2dc08b9df60921dfd539bd.jpg";
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  bool isvisible = true;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Future authsigup(
      {required email,
      required password,
      required name,
      required number,
      required String urllink,
      required BuildContext context}) async {
    try {
      var ref = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      var docid = ref.user!.uid.toString();
      var data = {
        "email": email,
        "password": password,
        "name": name,
        "number": number,
        "url": urllink
      };
      var dbref = await FirebaseFirestore.instance
          .collection("Mydatabase")
          .doc(docid)
          .set(data);
      Fluttertoast.showToast(msg: "success");
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginpage(),
          ));
    } on FirebaseException catch (e) {
      Fluttertoast.showToast(msg: e.code);
    } catch (e) {
      Fluttertoast.showToast(msg: "error");
    }
  }

  Future databasestore(email, password, name, number, docid) async {
    var data = {
      "email": email,
      "password": password,
      "name": name,
      "number": number,
      "url": urllink
    };
    var dbref = await FirebaseFirestore.instance
        .collection("Mydatabase")
        .doc(docid)
        .set(data);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formkey,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            "https://i2.wp.com/files.123freevectors.com/wp-content/original/154061-abstract-blue-and-white-background.jpg",
                          ),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          cust_textformfield(
                              keyboad: TextInputType.name,
                              command: "enter your name",
                              command2: "enter your full name",
                              controller: namecontroller,
                              label: "Enter your name",
                              preicon: const Icon(Icons.person)),
                          cust_textformfield(
                              keyboad: TextInputType.emailAddress,
                              command: "enter your email",
                              command2: "enter proper email id",
                              controller: emailcontroller,
                              label: "Enter your email",
                              preicon: const Icon(Icons.email)),
                          cust_textformfield(
                              keyboad: TextInputType.phone,
                              command: "enter your phone number",
                              command2: "enter valid number",
                              controller: numbercontroller,
                              label: "Enter your number",
                              preicon: const Icon(Icons.phone)),
                          cust_textformfield(
                              keyboad: TextInputType.name,
                              command: "emter your password",
                              command2: "enter a strong password",
                              controller: passcontroller,
                              label: "Enter your password",
                              preicon: const Icon(Icons.lock)),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  authsigup(
                                      urllink: urllink,
                                      email: emailcontroller.text,
                                      password: passcontroller.text,
                                      name: namecontroller.text,
                                      number: numbercontroller.text,
                                      context: context);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const Loginpage(),
                                      ));
                                } else {
                                  "something went wrong";
                                }
                              },
                              child: const Text("signup")),
                          Row(
                            children: [
                              const Text(
                                "ALREADY HAVE AN ACCOUNT?",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Loginpage(),
                                        ));
                                  },
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
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
