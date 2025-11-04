import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'custom_morphisum.dart';
import 'fire_store.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginSignup extends StatefulWidget {
  const LoginSignup({super.key});

  @override
  State<LoginSignup> createState() => _LoginSignupState();
}

class _LoginSignupState extends State<LoginSignup> {
  bool isSigningIn = false;
  bool isSignUp = false;
  bool isselect = false;
  // ignore: non_constant_identifier_names
  final userController_login = TextEditingController();
  // ignore: non_constant_identifier_names
  final passwordController_login = TextEditingController();
  // ignore: non_constant_identifier_names
  final userController_signin = TextEditingController();
  // ignore: non_constant_identifier_names
  final passwordController_singin_1 = TextEditingController();
  // ignore: non_constant_identifier_names
  final passwordController_singin_2 = TextEditingController();

  String user = "";
  // ignore: non_constant_identifier_names
  TextEditingController emailcontroller_login = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController emailcontroller_signin = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final GlobalKey<FormState> _logKey = GlobalKey();
  Firestoreservics fire = Firestoreservics();

  // ignore: non_constant_identifier_names
  String display_text() {
    if (isSignUp) {
      return "Not a member?";
    } else {
      return "Already a member?";
    }
  }

  void clearTextField() {
    userController_login.clear();
    passwordController_login.clear();
    userController_signin.clear();
    passwordController_singin_1.clear();
    passwordController_singin_2.clear();
    emailcontroller_login.clear();
    emailcontroller_signin.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.fill,
          // ),
          Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height: 300,
                decoration: const BoxDecoration(color: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 50, 0, 0),
                      child: RichText(
                          text: TextSpan(
                              text: "Welcome",
                              style: TextStyle(
                                  fontFamily: "Platypi",
                                  fontSize: 55,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold))),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        display_text(),
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ],
                ),
              )),
          Positioned(
              top: 180,
              left: 30,
              child: CustomMorphisum(
                radius: 20,
                height: isSignUp ? 370 : 250,
                width: MediaQuery.of(context).size.width - 50,
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            clearTextField();
                            setState(() {
                              isSignUp = false;
                              isSigningIn = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignUp
                                        ? Theme.of(context).colorScheme.primary
                                        : const Color.fromARGB(
                                            255, 170, 197, 211)),
                              ),
                              if (!isSignUp)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.black,
                                )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            clearTextField();
                            setState(() {
                              isSignUp = true;
                              isSigningIn = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "Signup",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignUp
                                        ? const Color.fromARGB(
                                            255, 170, 197, 211)
                                        : Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              if (isSignUp)
                                Container(
                                  margin: const EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.black,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignUp) buildSign(),
                    if (!isSignUp) builtLogin(),
                  ],
                ),
              )),
          Positioned(
            top: isSignUp ? 510 : 400,
            right: 0,
            left: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  if (isSignUp) {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      signUp();
                    }
                  } else {
                    if (_logKey.currentState!.validate()) {
                      _logKey.currentState!.save();
                      _signIn();
                    } else {}
                  }
                },
                child: Container(
                  height: 90,
                  width: 90,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 233, 236, 237),
                              Color.fromARGB(255, 103, 103, 103)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(30)),
                    child: isSigningIn
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form builtLogin() {
    return Form(
        key: _logKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                controller: emailcontroller_login,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: "Email",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: const Icon(Icons.person),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(135, 182, 182, 182)),
                      borderRadius: BorderRadius.circular(35)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (value) {
                  String pattern = r"\w+@\w+\.\w+";
                  if (value == null || value.isEmpty) {
                    return "Enter email id";
                  } else if (!RegExp(pattern).hasMatch(value)) {
                    return "Invalid email address format";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                controller: passwordController_login,
                textInputAction: TextInputAction.next,
                obscureText: isselect,
                decoration: InputDecoration(
                  hintText: "PASSWORD",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  labelText: "PASSWORD ",
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(135, 182, 182, 182)),
                      borderRadius: BorderRadius.circular(35)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isselect = !isselect;
                      });
                    },
                    icon: isselect
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Password";
                  } else if (value.length < 7) {
                    return "password is too short";
                  }
                  return null;
                },
              ),
            ),
          ],
        ));
  }

  Form buildSign() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextFormField(
          //     controller: userController_signin,
          //     textInputAction: TextInputAction.next,
          //     decoration: InputDecoration(
          //       hintText: "USER NAME",
          //       hintStyle: const TextStyle(
          //         color: Colors.white,
          //       ),
          //       labelText: "USER NAME ",
          //       suffixIcon: const Icon(Icons.person),
          //       enabledBorder: OutlineInputBorder(
          //           borderSide: const BorderSide(
          //               color: Color.fromARGB(135, 182, 182, 182)),
          //           borderRadius: BorderRadius.circular(35)),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //     ),
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return "Enter  Name";
          //       }
          //       return null;
          //     },
          //     onSaved: (value) => user = value!,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              controller: emailcontroller_signin,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                labelText: "Email",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                suffixIcon: const Icon(Icons.person),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(135, 182, 182, 182)),
                    borderRadius: BorderRadius.circular(35)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              validator: (value) {
                String pattern = r"\w+@\w+\.\w+";
                if (value == null || value.isEmpty) {
                  return "Enter email id";
                } else if (!RegExp(pattern).hasMatch(value)) {
                  return "Invalid Email address format";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController_singin_1,
              textInputAction: TextInputAction.next,
              obscureText: isselect,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              decoration: InputDecoration(
                hintText: "PASSWORD",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                labelText: "PASSWORD ",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(135, 182, 182, 182)),
                    borderRadius: BorderRadius.circular(35)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isselect = !isselect;
                    });
                  },
                  icon: isselect
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Password";
                } else if (value.length < 7) {
                  return "password is too short";
                } else if (passwordController_singin_1.text !=
                    passwordController_singin_2.text) {
                  return "Enter same passoword";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
              controller: passwordController_singin_2,
              textInputAction: TextInputAction.next,
              obscureText: isselect,
              decoration: InputDecoration(
                hintText: "RE-PASSWORD",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                labelText: "RE-PASSWORD ",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(135, 182, 182, 182)),
                    borderRadius: BorderRadius.circular(35)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isselect = !isselect;
                    });
                  },
                  icon: isselect
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter Password";
                } else if (value.length < 7) {
                  return "password is too short";
                } else if (passwordController_singin_1.text !=
                    passwordController_singin_2.text) {
                  return "Enter same passoword";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 400,
                height: 50,
                margin: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const Text("By pressing arrow you agree to our"),
                    GestureDetector(
                        onTap: () {
                          _popup(context);
                        },
                        child: const Text("term &conditions",
                            style: TextStyle(color: Colors.orange)))
                  ],
                )),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  Future _signIn() async {
    setState(() {
      isSigningIn = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailcontroller_login.text,
          password: passwordController_login.text);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          webBgColor: "#1E88E5");
    }
  }

  Future signUp() async {
    setState(() {
      isSigningIn = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller_signin.text,
          password: passwordController_singin_1.text);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message!,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        webBgColor: "#1E88E5",
      );
    }
  }

  Future<AwesomeDialog> _popup(context) async {
    return await AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
      width: MediaQuery.of(context).size.width * 0.8,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
      dismissOnTouchOutside: true,
      animType: AnimType.bottomSlide,
      desc:
          "This is a flutter project created by jyothi engineering students \n So NO terms and conditions ENJOY!!",
      showCloseIcon: true,
    ).show();
  }
}
