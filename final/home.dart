// ignore_for_file: sort_child_properties_last

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:staff_portal/fire_store.dart';
import 'custom_morphisum.dart';
import 'drawer_nav.dart';
import 'registration_form.dart';
import 'staff_list.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isPressed = false;
  // ignore: non_constant_identifier_names
  CarouselController carouselController = CarouselController();
  @override
  void initState() {
    super.initState();
  }

  Firestoreservics fire = Firestoreservics();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // final themeState = Provider.of<ThemeProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      drawer: const DrawerNav(),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        // Lottie.asset(
        //   "lib/image/Background_lottie_2.json",
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   fit: BoxFit.fill,
        // ),
        Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                child: CustomMorphisum(
                  radius: 30,
                  width: 100,
                  height: 200,
                  child: Center(
                    child: Text(
                      "Hello !!\nGet Started",
                      style: TextStyle(
                        fontFamily: "Platypi",
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.transparent,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPressed = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationForm(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(70.0, 0, 70, 0),
                  child: CustomMorphisum(
                      radius: 20,
                      child: Center(
                        child: Text(
                          "New Registration",
                          style: TextStyle(
                            fontFamily: "Platypi",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      width: 100,
                      height: 70),
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isPressed = true;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StaffList(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(70.0, 0, 70, 0),
                  child: CustomMorphisum(
                      radius: 20,
                      child: Center(
                        child: Text(
                          "Staff List",
                          style: TextStyle(
                            fontFamily: "Platypi",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      width: 300,
                      height: 70),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: CustomMorphisum(
                  width: 300,
                  height: 65,
                  radius: 20,
                  child: Center(
                    child: Text(
                      "Latest Registered Staff",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: fire.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData && snapshot.data!.docs.length > 1) {
                        List notelist = snapshot.data!.docs;
                        return CarouselSlider.builder(
                            itemCount: notelist.length,
                            itemBuilder: (context, index, __) {
                              DocumentSnapshot document = notelist[index];
                              return Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          offset: const Offset(-4, -4),
                                          blurRadius: 10,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          offset: const Offset(4, 4),
                                          blurRadius: 10,
                                          spreadRadius: 1)
                                    ],
                                    border: Border.all(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30)),
                                    gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          Theme.of(context)
                                              .colorScheme
                                              .secondary
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight),
                                  ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height: 70,
                                  child: Center(
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        _popup_details(context, document);
                                      },
                                      child: Text(
                                        "${document["firstname"]} ${document["lastname"]}",
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            options: CarouselOptions(
                              height: 70,
                              enlargeCenterPage: true,
                              enlargeFactor: 0.4,
                              autoPlay: true,
                              enableInfiniteScroll: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                            ));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.hasError.toString()} "),
                        );
                      } else {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 70,
                          child: const Center(
                            child: Text("NO DATA FOUND"),
                          ),
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0, 40, 0),
                  child: SlideAction(
                    borderRadius: 17,
                    elevation: 0,
                    innerColor: Theme.of(context).colorScheme.secondary,
                    outerColor: Theme.of(context).colorScheme.tertiary,
                    sliderButtonIcon: const Icon(Icons.logout),
                    text: "Slide to Log-Out",
                    textStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary),
                    onSubmit: () {
                      _popup(context);
                      return;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
        tooltip: 'Drawer',
        child: Icon(
          Icons.menu,
          color: Theme.of(context).colorScheme.primary,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        splashColor: Colors.brown[100],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Future<AwesomeDialog> _popup(context) async {
    return await AwesomeDialog(
        dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
        context: context,
        dialogType: DialogType.warning,
        width: MediaQuery.of(context).size.width * 0.8,
        buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
        dismissOnTouchOutside: true,
        animType: AnimType.bottomSlide,
        desc: "Log-Out\nCome back Soon!!!",
        showCloseIcon: true,
        btnOkOnPress: () {
          FirebaseAuth.instance.signOut();
        }).show();
  }

  // ignore: non_constant_identifier_names
  Future<AwesomeDialog> _popup_details(context, document) async {
    return await AwesomeDialog(
      dialogBackgroundColor: Theme.of(context).colorScheme.secondary,
      context: context,
      dialogType: DialogType.noHeader,
      width: MediaQuery.of(context).size.width * 0.8,
      buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
      dismissOnTouchOutside: true,
      animType: AnimType.bottomSlide,
      desc:
          "Name:${document["firstname"]} ${document["lastname"]}\nSubject:${document["subject"]}\nEducation:${document["edu"]}",
      autoDismiss: true,
      descTextStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
      autoHide: const Duration(seconds: 4),
    ).show();
  }

  // ignore: non_constant_identifier_names
  // String text_for_popup(document) {
  //   return "Name:${document["firstname"]} ${document["lastname"]}\nSubject:${document["subject"]}\nEducation:${document["edu"]}";
  // }
}
