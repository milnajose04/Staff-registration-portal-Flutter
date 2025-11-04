import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "custom_glass_effect.dart";
import "custom_morphisum.dart";
import "fire_store.dart";
import "profile_page.dart";

class ProfileList extends StatefulWidget {
  const ProfileList({super.key});

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  User? user;
  Map<String, dynamic>? userData;
  var time = DateTime.now();
  bool isLoading = true;
  String? docID;
  Firestoreservics fire = Firestoreservics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Profile List",
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
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.width,
          //   fit: BoxFit.fill,
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 0),
              child: CustomGlassEffect(
                  blur: 0,
                  opacity: 0,
                  bottomRight: 20,
                  bottomLeft: 20,
                  topRight: 20,
                  topLeft: 20,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder<QuerySnapshot>(
                      future: getProfile(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          List notelist = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: notelist.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document = notelist[index];
                              return Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20.0, 8, 20, 8),
                                child: CustomMorphisum(
                                  radius: 20,
                                  width: MediaQuery.of(context).size.width,
                                  height: 70,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    leading: Icon(Icons.person,
                                        size: 30,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    title: Text(
                                      "${document["firstname"]}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    subtitle: Text(
                                      "${document["subject"]}",
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProfilePage(
                                                        document: document,
                                                      )));
                                        },
                                        icon: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)),
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("${snapshot.hasError.toString()} "),
                          );
                        } else {
                          return const Center(
                            child: Text("NO DATA FOUND"),
                          );
                        }
                        // } else {
                        //   print(snapshot);
                        //   return const Center(
                        //     child: CircularProgressIndicator(),
                        //   );
                        // }
                      })),
            ),
          ),
        ],
      ),
    );
  }

  Future<QuerySnapshot> getProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser?.email;
    // ignore: non_constant_identifier_names
    final profile_list = await FirebaseFirestore.instance
        .collection("Details")
        .where("email", isEqualTo: email)
        .get();
    return profile_list;
  }
}
