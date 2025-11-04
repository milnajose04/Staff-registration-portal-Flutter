import 'package:cloud_firestore/cloud_firestore.dart';

class FormModel {
  String firstname;
  String lastname;
  String address;
  String paddress;
  String subject;
  String college;
  String experience;
  String edu;
  String year;
  String mobile;
  String email;
  String sex;
  String id;

  FormModel(
      {required this.email,
      required this.id,
      required this.firstname,
      required this.lastname,
      required this.address,
      required this.paddress,
      required this.subject,
      required this.college,
      required this.experience,
      required this.edu,
      required this.year,
      required this.mobile,
      required this.sex});

  // Map<String, dynamic> toMap() {
  //   return {
  //     'firstname': firstname,
  //     'lastname': lastname,
  //     'address': address,
  //     'paddress': paddress,
  //     'subject': subject,
  //     'college': college,
  //     'experience': experience,
  //     'edu': edu,
  //     "year": year,
  //     "mobile": mobile,
  //     "email": email,
  //     "sex": sex,
  //   };
  // }

  factory FormModel.formSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return FormModel(
        email: data["email"],
        id: document.id,
        firstname: data["firstname"],
        lastname: data["lastname"],
        address: data["address"],
        paddress: data["paddress"],
        subject: data["subject"],
        college: data["college"],
        experience: data["experience"],
        edu: data["edu"],
        year: data["year"],
        mobile: data["mobile"],
        sex: data["sex"]);
  }

  //  Future<FormModel> getUserDetails(String email) async {
  //   final snapshot = await firestore.where("email", isEqualTo: email).get();
  //   final userdata = snapshot.docs.map((e) => FormModel.formSnapshot(e)).single;
  //   return userdata;
  // }
}
