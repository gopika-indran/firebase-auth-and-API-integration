import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mock/home.dart';
import 'package:mock/signuppage.dart';
import 'package:mock/textfformieldcust.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
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
                          image: AssetImage("assets/images/logimag.jpg"),
                          fit: BoxFit.cover)),
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 1.2,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            "LOGIN PAGE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          cust_textformfield(
                              keyboad: TextInputType.emailAddress,
                              command: "enter your email",
                              command2: "enter proper email id",
                              controller: emailcontroller,
                              label: "Enter your email",
                              preicon: const Icon(Icons.email)),
                          cust_textformfield(
                              keyboad: TextInputType.name,
                              command: "enter your password",
                              command2: "enter valid password",
                              controller: passcontroller,
                              label: "Enter your password",
                              preicon: const Icon(Icons.phone)),
                          ElevatedButton(
                              onPressed: () {
                                if (formkey.currentState!.validate()) {
                                  loginauth(
                                      email: emailcontroller.text,
                                      password: passcontroller,
                                      context: context);
                                }
                              },
                              child: const Text("Login")),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Text("Do not have an account?"),
                                const SizedBox(
                                  width: 7,
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const signuppage(),
                                          ));
                                    },
                                    child: const Text("Signup"))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        )),
      ),
    );
  }
}

Future loginauth(
    {required String email,
    required TextEditingController password,
    required BuildContext context}) async {
  try {
    var ref = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password.text);
    Fluttertoast.showToast(msg: "success");
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  } on FirebaseAuthException catch (e) {
    print("Login failed: ${e.message}"); // Print out the error message
    Fluttertoast.showToast(
        msg: "Login failed: ${e.message}", backgroundColor: Colors.red);
  }
}
