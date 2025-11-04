// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staff_portal/custom_glass_effect.dart';
import 'custom_morphisum.dart';
import 'fire_store.dart';

class StaffList extends StatefulWidget {
  const StaffList({super.key});

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  Firestoreservics fire = Firestoreservics();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 59, 81, 209),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Staff List",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Theme.of(context).colorScheme.primary),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
      body: Stack(
        children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.fill,
          // ),

          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         showSearch(
          //           context: context,
          //           delegate: CustomShowDelegate(),
          //         );
          //       },
          //       icon: const Icon(
          //         Icons.search,
          //         color: Colors.black,
          //       ))
          // ],
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
                  child: StreamBuilder<QuerySnapshot>(
                      stream: fire.getNotes(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
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
                                      contentPadding: EdgeInsets.all(5),
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
                                            _bottompopup(context, document);
                                          },
                                          icon: Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )),
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
                            return Center(
                              child: Text("NO DATA FOUND"),
                            );
                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      })),
            ),
          ),
        ],
      ),
    );
  }

  void _bottompopup(context, document) {
    var time = DateTime.now();
    showModalBottomSheet(
        context: context,
        builder: (context) => CustomMorphisum(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width,
              radius: 20,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ))),
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text(
                                "${document["firstname"]}",
                                style: TextStyle(
                                  fontSize: 23,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.clear_rounded,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ))
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                fontFamily: "Platypi",
                                color: Theme.of(context).colorScheme.primary),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Name :  ',
                              ),
                              TextSpan(
                                  text:
                                      '${document["firstname"]} ${document["lastname"]} \n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                text: 'Subject :  ',
                              ),
                              TextSpan(
                                  text: '${document["subject"]}\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                              TextSpan(
                                text: 'Age :',
                              ),
                              TextSpan(
                                text:
                                    '${time.year - int.parse(document["year"])}      ',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(text: "Sex : ", children: [
                                TextSpan(
                                  text: "${document["sex"]}   ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal),
                                ),
                                WidgetSpan(child: _showSex(document)),
                              ]),
                              TextSpan(
                                text: '\nEducation :',
                              ),
                              TextSpan(
                                text: '${document["edu"]} \n',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text: 'Experience :',
                              ),
                              TextSpan(
                                text: '${document["experience"]} \n',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text: 'Mobile Number :',
                              ),
                              TextSpan(
                                text: '${document["mobile"]} \n',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text: 'Email :',
                              ),
                              TextSpan(
                                text: '${document["email"]} \n',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                              TextSpan(
                                text: 'Address :',
                              ),
                              TextSpan(
                                text: '${document["address"]} \n',
                                style: TextStyle(fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  Widget _showSex(document) {
    if ("${document["sex"]}" == "Male") {
      return Icon(
        Icons.male,
        color: Colors.blue[600],
      );
    } else if ("${document["sex"]}" == "Female") {
      return Icon(Icons.female, color: Colors.pink[300]);
    } else {
      return Icon(Icons.transgender);
    }
  }
}

class CustomShowDelegate extends SearchDelegate {
  List<String> searchTerm = [
    " Alice Johnson",
    " Robert Smith",
    " Sarah Davis",
    " Michael Brown",
    " Emily Wilson",
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerm) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerm) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
