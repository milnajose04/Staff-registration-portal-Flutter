import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Firestoreservics {
  //get
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection("Details");

  //create
  Future addNotes(
      firstname,
      lastname,
      presentAdd,
      permenentAdd,
      subject,
      college,
      selectedExperience,
      education,
      selectedYear,
      mobilenumber,
      email,
      gender) async {
    return await firestore.add({
      'firstname': firstname,
      'lastname': lastname,
      'address': presentAdd,
      'paddress': permenentAdd,
      'subject': subject,
      'college': college,
      'experience': selectedExperience,
      'edu': education,
      "year": selectedYear,
      "mobile": mobilenumber,
      "email": email,
      "sex": gender,
    });
  }

  //read
  Stream<QuerySnapshot> getNotes() {
    final notestream = firestore.snapshots();
    return notestream;
  }

  Future<QuerySnapshot> getProfile() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String? email = currentUser?.email;
    // ignore: non_constant_identifier_names
    final profile_list = await firestore.where("email", isEqualTo: email).get();
    return profile_list;
  }
}
