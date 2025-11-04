import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:staff_portal/fire_store.dart';

import 'custom_morphisum.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  Future<void> _selectdate() async {
    DateTime? picked = await showDatePicker(
        barrierColor: Theme.of(context).colorScheme.secondary,
        cancelText: "Cancel",
        context: context,
        firstDate: DateTime(1990),
        lastDate: DateTime(2024));
    if (picked != null) {
      setState(() {
        dateController.text = picked.toString().split(" ")[0];
        selectedYear = dateController.text.substring(0, 4);
      });
    }
  }

  Firestoreservics fire = Firestoreservics();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final addressController = TextEditingController();
  final paddressController = TextEditingController();
  final subjectController = TextEditingController();
  final collegeController = TextEditingController();
  final eduController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? gender;
  String? selectedYear;

  String firstname = "";
  String mobilenumber = "";
  String email = "";
  String education = "";
  String college = "";
  String subject = "";
  String permenentAdd = "";
  String presentAdd = "";
  String dateofbirth = "";
  String lastname = "";

  List<int> yearsofexperience = List<int>.generate(10, (i) => i + 1);
  int? selectedExperience;

  void clearTextField() {
    mobileController.clear();
    firstnameController.clear();
    lastnameController.clear();
    addressController.clear();
    paddressController.clear();
    subjectController.clear();
    collegeController.clear();
    eduController.clear();
    dateController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "Registration Form",
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
        body: Stack(children: [
          // Lottie.asset(
          //   "lib/image/Background_lottie_2.json",
          //   width: MediaQuery.of(context).size.width,
          //   height: MediaQuery.of(context).size.height,
          //   fit: BoxFit.fill,
          // ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomMorphisum(
                  radius: 20,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Form(
                    key: _formKey,
                    child: ListView(children: [
                      Column(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Row(children: [
                            Expanded(
                                child: ListTile(
                              title: Text(
                                "First Name",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              subtitle: TextFormField(
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                // key: _textFieldKey,
                                controller: firstnameController,
                                textInputAction: TextInputAction.continueAction,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    hintText: "Enter First Name",
                                    hintStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter First name";
                                  }
                                  return null;
                                },
                                onSaved: (value) => firstname = value!,
                              ),
                            )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: ListTile(
                              title: Text("Last Name",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              subtitle: TextFormField(
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                controller: lastnameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    hintText: "Enter Last Name",
                                    hintStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter Last name";
                                  }
                                  return null;
                                },
                                onSaved: (value) => lastname = value!,
                              ),
                            )),
                          ]),
                          const SizedBox(height: 10),
                          ListTile(
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: dateController,
                              decoration: InputDecoration(
                                fillColor:
                                    Theme.of(context).colorScheme.secondary,
                                labelText: "Date of birth",
                                labelStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                filled: true,
                                prefixIcon: Icon(Icons.calendar_month_outlined,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              readOnly: true,
                              onTap: _selectdate,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter date of birth";
                                }
                                return null;
                              },
                              onSaved: (value) => dateofbirth = value!,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text("Gender",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 17,
                                color: Theme.of(context).colorScheme.primary,
                              )),

                          //Selecting gender
                          FormField(
                            builder: (state) {
                              return Column(
                                children: [
                                  RadioListTile<String>(
                                    fillColor: WidgetStatePropertyAll(
                                        Theme.of(context).colorScheme.primary),
                                    tileColor:
                                        Theme.of(context).colorScheme.primary,
                                    title: Text('Male',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )),
                                    value: 'Male',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    fillColor: WidgetStatePropertyAll(
                                        Theme.of(context).colorScheme.primary),
                                    title: Text('Female',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )),
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                  ),
                                  RadioListTile<String>(
                                    fillColor: WidgetStatePropertyAll(
                                        Theme.of(context).colorScheme.primary),
                                    title: Text('Other',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        )),
                                    value: 'Other',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value!;
                                      });
                                    },
                                  ),
                                  Text(state.errorText ?? " ",
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              );
                            },
                            validator: (value) {
                              if (gender == null) {
                                return "Select a gender";
                              }
                              return null;
                            },
                          ),

                          ListTile(
                            title: Text("Present Address",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: addressController,
                              //  textInputAction:TextInputAction.next ,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: "Enter present address",
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Present Address";
                                }
                                return null;
                              },
                              onSaved: (value) => presentAdd = value!,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                            ),
                          ),
                          ListTile(
                            title: Text("Permanent Address",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: paddressController,
                              //  textInputAction:TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: 'Enter permanent address',
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Permanent Address";
                                }
                                return null;
                              },
                              onSaved: (value) => permenentAdd = value!,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 3,
                            ),
                          ),
                          ListTile(
                            title: Text("Subject",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: subjectController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: "Subject",
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Subject";
                                }
                                return null;
                              },
                              onSaved: (value) => subject = value!,
                            ),
                          ),
                          ListTile(
                            title: Text("College",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: collegeController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  hintText: "College",
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter College";
                                }
                                return null;
                              },
                              onSaved: (value) => college = value!,
                            ),
                          ),
                          ListTile(
                            title: Text("Educational Qualification",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              controller: eduController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText:
                                      "Enter Your Educational Qualifications",
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Educational Qualification";
                                }
                                return null;
                              },
                              onSaved: (value) => education = value!,
                            ),
                          ),
                          ListTile(
                            title: Text("Years of Experience",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: DropdownButtonFormField<int>(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              value: selectedExperience,
                              hint: Text('Years of Experience',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              items: yearsofexperience.map((int value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(value.toString()),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedExperience = newValue;
                                });
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              validator: (value) => value == null
                                  ? 'Please select years of experience'
                                  : null,
                            ),
                          ),
                          ListTile(
                              title: Text("E-mail ID",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              subtitle: TextFormField(
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                controller: emailController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    hintText: "Enter email id",
                                    hintStyle: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.lightBlue,
                                    )),
                                validator: (value) {
                                  String pattern = r"\w+@\w+\.\w+";
                                  if (value == null || value.isEmpty) {
                                    return "Enter email id";
                                  } else if (!RegExp(pattern).hasMatch(value)) {
                                    return "Invalid address format";
                                  }
                                  return null;
                                },
                                onSaved: (value) => email = value!,
                              )),
                          ListTile(
                            title: Text("Mobile number",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            subtitle: TextFormField(
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                              onChanged: (value) {
                                _formKey.currentState?.validate();
                              },
                              keyboardType: TextInputType.phone,
                              controller: mobileController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: "+91 xxxxx xxxxx",
                                  hintStyle: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the number';
                                } else if (!RegExp(
                                        r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$")
                                    .hasMatch(value)) {
                                  return 'Please enter valid number';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) => mobilenumber = value!,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _popup(context);
                                  }
                                },
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 2, 48, 86)),
                                )),
                          ),
                        ],
                      ),
                    ]),
                  )),
            ),
          ),
        ]));
  }

  Future<AwesomeDialog> _popup(context) async {
    return await AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        width: MediaQuery.of(context).size.width * 0.8,
        buttonsBorderRadius: const BorderRadius.all(Radius.circular(30)),
        dismissOnTouchOutside: true,
        animType: AnimType.bottomSlide,
        desc:
            "Confirm ?\nNOTE:After Submission changes are possible in profile\nEXCEPT EMAIL",
        showCloseIcon: true,
        btnOkOnPress: () {
          fire.addNotes(
              firstname,
              lastname,
              presentAdd,
              permenentAdd,
              subject,
              college,
              selectedExperience.toString(),
              education,
              selectedYear.toString(),
              mobilenumber,
              email,
              gender!);
          clearTextField();
          Navigator.of(context).pop();
        }).show();
  }
}
