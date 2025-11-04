import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'custom_morphisum.dart';
import 'profile_box.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  DocumentSnapshot document;
  ProfilePage({super.key, required this.document});

  @override
  // ignore: no_logic_in_create_state
  State<ProfilePage> createState() => _ProfilePageState(document);
}

class _ProfilePageState extends State<ProfilePage> {
  DocumentSnapshot document;
  _ProfilePageState(this.document);
  User? user;
  Map<String, dynamic>? userData;
  var time = DateTime.now();
  bool isLoading = true;
  String? docID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary)),
      ),
      body: Stack(
        children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width * 1.25,
          //   height: MediaQuery.of(context).size.width * 1.45,
          //   fit: BoxFit.fill,
          // ),
          Center(
            child: CustomMorphisum(
                radius: 20,
                width: MediaQuery.of(context).size.width * 0.95,
                height: 500,
                child: Myprofile(document.data() as Map<String, dynamic>)),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  ListView Myprofile(document) {
    return ListView(children: [
      const Icon(
        Icons.person,
        color: Colors.white,
        size: 70,
      ),
      ProfileBox(
        mainText: "First Name",
        onPressed: () {
          editProfile("firstname");
        },
        subText: "${document["firstname"]}",
      ),
      ProfileBox(
        mainText: "Last Name",
        onPressed: () {
          editProfile("lastname");
        },
        subText: "${document["lastname"]}",
      ),
      ProfileBox(
        mainText: "Current Address",
        onPressed: () {
          editProfile("address");
        },
        subText: "${document["address"]}",
      ),
      // ProfileBox(
      //   mainText: "Subject Learned",
      //   onPressed: () {
      //     editProfile("subject");
      //   },
      //   subText: "${document["subject"]}",
      // ),
      ProfileBox(
        mainText: "College",
        onPressed: () {
          editProfile("college");
        },
        subText: "${document["college"]}",
      ),
      // ProfileBox(
      //   mainText: "Experience",
      //   onPressed: () {
      //     editProfile("experience");
      //   },
      //   subText: "${document["experience"]}",
      // ),
      ProfileBox(
        mainText: "Mobile Number",
        onPressed: () {
          editProfile("mobile");
        },
        subText: "${document["mobile"]}",
      ),
      ProfileBox(
        mainText: "Education",
        onPressed: () {
          editProfile("edu");
        },
        subText: "${document["edu"]}",
      ),
    ]);
  }

  Future<void> editProfile(String field) async {
    docID = document.id;
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Text(
                "Edit $field",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              content: TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Enter new $field",
                    hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary)),
                onChanged: (value) {
                  newValue = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                TextButton(
                    onPressed: () => Navigator.of(context).pop(newValue),
                    child: const Text("Save")),
              ],
            ));

    // ignore: prefer_is_empty
    if (newValue.trim().length > 0) {
      await FirebaseFirestore.instance
          .collection('Details')
          .doc(docID)
          .update({field: newValue});
    }
  }
}
